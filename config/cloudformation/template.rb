require 'yaml'

CloudFormation {
  AWSTemplateFormatVersion "2010-09-09"
  Description "CloudFormation Template for Indigenous Literacy Foundation"

  create_security_groups([
    { "Name" => "LoadBalancerSecurityGroup", "Description" => "Security policies for the Load Balancer"},
    { "Name" => "HackInstanceSecurityGroup", "Description" => "Security policies for the Instance"}                         
  ], vpc)

  create_security_group_rules([
    { "SourceSecurityGroupId" => "LoadBalancerSecurityGroup", "IpProtocol" => "tcp", "Ports" => ["1-65535"],  "DestinationSecurityGroupId" => "HackInstanceSecurityGroup" }
  ])

  Resource("LoadBalancer") {
    Type "AWS::ElasticLoadBalancing::LoadBalancer"
    Property "SecurityGroups", [Ref("LoadBalancerSecurityGroup"), account_info['vha_other_inbound_sg']]
    Property("Subnets", config['subnets'].map { |balancer_subnet|
      balancer_subnet
    })
    Property("LBCookieStickinessPolicy", [
      { "PolicyName" => "HTTPSStickySessionPolicy" }
    ])
    Property "Instances", [Ref("HackInstance")]
    Property "Scheme", "internal"
    Property("Listeners",
      [
        { "LoadBalancerPort" => "80", "InstancePort" => "80", "Protocol" => "HTTP", "InstanceProtocol" => "HTTP" },
        { "LoadBalancerPort" => "443", "InstancePort" => "8000", "Protocol" => "HTTPS", "InstanceProtocol" => "HTTP", "SSLCertificateId" => config["ssl_certificate_id"], "PolicyNames" => ["HTTPSStickySessionPolicy"] }
      ]
    )
    Property("HealthCheck", {
      "Target" => "TCP:80",
      "HealthyThreshold" => "2",
      "UnhealthyThreshold" => "5",
      "Interval"=> "30",
      "Timeout" => "15"
    })
  }

  cfn_ec2_config = VhaBase::CloudFormation::CfnEc2Configuration.new(
    platform: config['platform'],
    environment: config['environment'],
    creation_timeout_minutes: 300 
  )

  chef_attributes = {}

  app = VhaBase::CloudFormation::CfnApplication.new(
    name: 'hack_instance',
    url: '',
    chef_solo_config: 'chef/solo.rb',
    chef_run_list: [],
    chef_attributes: chef_attributes
  )

  tags = [
  ]

  ec2_name = "Hack"
  az = ['a', 'b']
  index = Random.rand(2)
  ec2_instance(ec2_name, "hack_instance", cfn_ec2_config, [app], tags).declare {
    Property('InstanceType', config['instance_type'])
    Property('KeyName', config['keypair'])
    Property('SubnetId', account_info.subnets['digital_build1'].zones[az[index]].id)
    Property('ImageId', config['ami'])
    Property('SecurityGroupIds', [
      account_info['linux_server_base_sg'],
      account_info['vha_other_inbound_sg'],
      account_info['vha_other_outbound_sg'],
      account_info['nat_access_sg'],
      Ref("HackInstanceSecurityGroup")
    ])
  }

  Resource("DNSRecord") {
    Type "AWS::Route53::RecordSet"
    Property "HostedZoneName", config['dns_zone'] + "."
    Property "Name", STACK_NAME + "." + config['dns_zone'] + "."
    Property "Type", "CNAME"
    Property "TTL", "900"
    Property "ResourceRecords", [FnGetAtt("LoadBalancer", "DNSName")]
  }
}