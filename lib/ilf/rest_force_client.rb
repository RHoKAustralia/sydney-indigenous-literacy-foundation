module ILF
  class RestForceClient
    def initialize
      @client = Restforce.new
    end

    def communities
      # puts @client.describe('Account')
      accounts = @client.query("select Name, Geolocation__c, Geolocation__latitude__s, Geolocation__longitude__s from Account where Online_Ordering_Category__c = 'Remote Community'")
      accounts.each do |account|
        puts "ACCOUNT: #{account}"
      end
      accounts
    end
  end
end