class CommunitySectionsController < ApplicationController
  #before_action :set_excitement_page, only: [:show, :edit, :update, :destroy,:email_list,:send_email,:show_image]
  before_action :set_excitement_page
  before_action :set_community_section , only: [:edit, :update]



  # GET /excitement_pages/new
  def new

    @communities = Community.order(:name).all
    puts "**************************************   #{params}"
    @community_section = CommunitySection.new
  end



 
    def create
    
    @communities = Community.order(:name).all

    puts "**************************************   #{params}"
    @community_section = CommunitySection.new(community_section_params)
    @community_section.excitement_page = @excitement_page
    @community_section.photo = Photo.new
    @community_section.photo.raw_data = params[:photo].read if params[:photo]

    respond_to do |format|
      if @community_section.save && @community_section.photo.save!
        format.html { redirect_to edit_excitement_page_path(@excitement_page), notice: 'Community Section was successfully created.' }
        format.json { render action: 'show', status: :created, location: @excitement_page }
      else
        format.html { render action: 'new' }
        format.json { render json: @community_section.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

    @communities = Community.order(:name).all
  end

    def update

    puts "**************************************   #{params}"

    @communities = Community.order(:name).all
    respond_to do |format|
      if params[:photo]
        @community_section.photo.destroy if @community_section.photo
        @community_section.photo = Photo.new
        @community_section.photo.raw_data = params[:photo].read if params[:photo]
      end
      if @community_section.update(community_section_params)
        format.html { redirect_to edit_excitement_page_path(@excitement_page), notice: 'Community Section was successfully updated.' }
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

    def set_community_section
      @community_section = CommunitySection.find(params[:id])
    end

    def community_section_params
      params.require(:community_section).permit(:community_text,:community_id)
    end


end