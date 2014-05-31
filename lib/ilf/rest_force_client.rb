module ILF
  class RestForceClient
    def initialize
      @client = Restforce.new
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
  end
end