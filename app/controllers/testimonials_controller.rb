class TestimonialsController < ApplicationController
  #before_action :set_excitement_page, only: [:show, :edit, :update, :destroy,:email_list,:send_email,:show_image]
  before_action :set_excitement_page
  before_action :set_testimonial , only: [:edit, :update,:show_image]



  # GET /excitement_pages/new
  def new

    puts "**************************************   #{params}"
    @testimonial = Testimonial.new
  end

    def create

    puts "**************************************   #{params}"
    @testimonial = Testimonial.new(testimonial_params)
    @testimonial.excitement_page = @excitement_page
    @testimonial.photo = Photo.new
    @testimonial.photo.raw_data = params[:photo].read if params[:photo]

    respond_to do |format|
      if @testimonial.save && @testimonial.photo.save!
        format.html { redirect_to edit_excitement_page_path(@excitement_page), notice: 'Testimonial was successfully created.' }
        format.json { render action: 'show', status: :created, location: @excitement_page }
      else
        format.html { render action: 'new' }
        format.json { render json: @testimonial.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

    def update
    respond_to do |format|
      @testimonial.photo.destroy if @testimonial.photo
      @testimonial.photo = Photo.new
      @testimonial.photo.raw_data = params[:photo].read if params[:photo]

      if @excitement_page.update(@testimonial)
        format.html { redirect_to @excitement_page, notice: 'Excitement page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @excitement_page.errors, status: :unprocessable_entity }
      end
    end
  end



    def set_excitement_page
      @excitement_page = ExcitementPage.find(params[:excitement_page_id])
    end

    def set_testimonial
      @excitement_page = ExcitementPage.find(params[:excitement_page_id])
    end

    def testimonial_params
      params.require(:testimonial).permit(:photo_caption, :text_block,:speaker_name,:speaker_role)
    end


end