class CommunitiesController < ApplicationController

  def show
    client = ILF::RestForceClient.new
    @community = client.community params[:id]
    @book_orders = client.book_orders(@community)
  end
end
