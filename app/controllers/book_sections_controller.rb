class BookSectionsController < ApplicationController
  #before_action :set_excitement_page, only: [:show, :edit, :update, :destroy,:email_list,:send_email,:show_image]
  before_action :set_excitement_page
  before_action :set_book_section , only: [:edit, :updatee]



  # GET /excitement_pages/new
  def new

    puts "**************************************   #{params}"
    @book_section = BookSection.new
  end

    def create

    puts "**************************************   #{params}"
    @book_section = BookSection.new()
    @book_section.excitement_page = @excitement_page
 

    respond_to do |format|
      if @book_section.save 
        list_of_photos = [params[:photo1],params[:photo2],params[:photo3],params[:photo4]]
        list_of_photos.compact!

        list_of_photos.each do |photo_info|
          photo = Photo.new
          photo.raw_data = photo_info.read
          photo.save!
          @book_section.photos << photo
        end
        @book_section.save!

        format.html { redirect_to edit_excitement_page_path(@excitement_page), notice: 'BookSection was successfully created.' }
        format.json { render action: 'show', status: :created, location: @excitement_page }
      else
        format.html { render action: 'new' }
        format.json { render json: @book_section.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

    def update
    respond_to do |format|
      list_of_photos = [params[:photo1],params[:photo2],params[:photo3],params[:photo4]]
      list_of_photos.compact!
      unless list_of_photos.empty?
        @book_section.photos.destroy_all
        list_of_photos.each do |photo_info|
          photo = Photo.new
          photo.raw_data = photo_info.read
          photo.save!
          @book_section.photos << photo
        end   
        if @book_section.save!  
          format.html { redirect_to edit_excitement_page_path(@excitement_page), notice: 'BookSection was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @excitement_page.errors, status: :unprocessable_entity }
        end
      end
    end  
  end



    def set_excitement_page
      @excitement_page = ExcitementPage.find(params[:excitement_page_id])
    end

    def set_book_section
      @book_section = BookSection.find(params[:id])
    end



end