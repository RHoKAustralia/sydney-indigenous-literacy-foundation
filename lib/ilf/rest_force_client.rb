module ILF
  class RestForceClient
    def initialize
      @client = Restforce.new cache: Rails.cache
    end

    def communities
      @client.query("SELECT Id
        , Name
        , Geolocation__c
        , Geolocation__latitude__s
        , Geolocation__longitude__s
        , BillingState
        FROM Account 
        WHERE Online_Ordering_Category__c = 'Remote Community' 
        ORDER BY Name")
    end

    def donations(from, to)
      @client.query("SELECT SUM(Amount)
        FROM Opportunity
        WHERE StageName = 'Closed Won' 
        AND CloseDate > #{from.strftime("%Y-%m-%d")}
        AND CloseDate < #{to.strftime("%Y-%m-%d")}").first.expr0
    end

    def community(community)
      @client.query("SELECT Id, Name, Geolocation__c, Geolocation__latitude__s, Geolocation__longitude__s, BillingState
        FROM Account 
        WHERE Id = '#{community.accountid}'").first
    end

    def book_orders(community)
      book_orders = @client.query("SELECT o.Id, o.AccountId, o.CloseDate, a.Name
        FROM Opportunity o, o.Account a
        WHERE o.Remote_Community__c = '#{community.accountid}'
        ORDER BY o.CloseDate DESC")
    end

    def donors_since(date)
      @client.query("SELECT Email, Last_Donation_Date__c
        FROM Contact
        WHERE Email != null
        AND Last_Donation_Date__c > #{date.strftime("%Y-%m-%d")}
        ORDER BY Last_Donation_Date__c DESC
        LIMIT 50")
    end
  end
end