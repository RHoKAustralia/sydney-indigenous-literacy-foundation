module ILF
  class RestForceClient
    def initialize
      @client = Restforce.new cache: Rails.cache
    end

    def communities
      # FILTER OUT NULL GEOLOCATIONS - will not show any communities that are above the equator !
      @client.query("SELECT Name
        , Geolocation__c
        , Geolocation__latitude__s
        , Geolocation__longitude__s 
        FROM Account 
        WHERE Online_Ordering_Category__c = 'Remote Community' 
        AND Geolocation__latitude__s < 0
        ORDER BY Name
      ")
    end

    def donations(from, to)
      # FILTER OUT NULL GEOLOCATIONS - will not show any communities that are above the equator !
      @client.query("SELECT SUM(Amount)
        FROM Opportunity
        WHERE StageName = 'Closed Won' 
        AND CloseDate > #{from.strftime("%Y-%m-%d")}
        AND CloseDate < #{to.strftime("%Y-%m-%d")}
      ").first.expr0
    end
  end
end