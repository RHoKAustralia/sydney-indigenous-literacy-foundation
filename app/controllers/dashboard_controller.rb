class DashboardController < ApplicationController
  def index
  	client = ILF::RestForceClient.new
  	@communities = client.communities
  end
end
