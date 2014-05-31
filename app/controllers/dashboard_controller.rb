class DashboardController < ApplicationController
  def index
  	client = ILF::RestForceClient.new
  	@communities = client.communities

    @today = Time.now
    @start_of_month = @today.beginning_of_month
    @start_of_year = @today.beginning_of_year
    @start_of_month_last_year = @today - 1.year
    @start_of_year_last_year = @start_of_year - 1.year

  	@donations_ytd = client.donations(@start_of_year, @today)
  	@donations_ytd_lastyear = client.donations(@start_of_year_last_year, @start_of_month_last_year)

  end
end
