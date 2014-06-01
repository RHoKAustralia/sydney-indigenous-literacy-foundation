class CommunitiesController < ApplicationController

  def show
    @community = Community.find params[:id]
    client = ILF::RestForceClient.new
    @book_orders = client.book_orders(@community)
  end
end
