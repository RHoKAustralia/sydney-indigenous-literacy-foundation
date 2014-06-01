module ILF
  class SalesForceService
    def self.load_communities
      client = RestForceClient.new
      communities = client.communities
      communities.each do |community|
        db_community = Community.find_by(accountid: community.Id)
        if db_community
          db_community.update_attributes(name: community.Name, accountid: community.Id, latitude: community.Geolocation__c.try(:latitude), longitude: community.Geolocation__c.try(:longitude))
        else
          db_community = Community.create(name: community.Name, accountid: community.Id, latitude: community.Geolocation__c.try(:latitude), longitude: community.Geolocation__c.try(:longitude))
        end

        community_profile = CommunityProfile.find_by(community_id: db_community.id)
        CommunityProfile.create(community: db_community) unless community_profile
      end
    end
  end
end