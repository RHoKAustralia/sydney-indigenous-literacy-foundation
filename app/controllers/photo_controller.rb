class PhotosController < ApplicationController

  def show
    puts "params #{params}"
    photo = Photo.find(params[:id])
    puts "HERERRERERRERERER************************"
    send_data photo.raw_data, :type => 'image/png',:disposition => 'inline'
  end
    

end
