class ExcitementPagesController < ApplicationController
  before_action :set_excitement_page, only: [:show, :edit, :update, :destroy,:email_list,:send_email,:show_image]

  # GET /excitement_pages
  # GET /excitement_pages.json
  def index
    @excitement_pages = ExcitementPage.all
  end

  # GET /excitement_pages/1
  # GET /excitement_pages/1.json
  def show
  end

  # GET /excitement_pages/new
  def new
    @excitement_page = ExcitementPage.new
  end

  # GET /excitement_pages/1/edit
  def edit
  end

  def show_image
    puts "params #{params}"
    photo = @excitement_page.photo
    puts "HERERRERERRERERER************************"
    send_data photo.raw_data, :type => 'image/png',:disposition => 'inline'
  end

  # POST /excitement_pages
  # POST /excitement_pages.json
  def create

    puts "**************************************   #{params}"
    @excitement_page = ExcitementPage.new(excitement_page_params)

    respond_to do |format|
      if @excitement_page.save
        format.html { redirect_to @excitement_page, notice: 'Excitement page was successfully created.' }
        format.json { render action: 'show', status: :created, location: @excitement_page }
      else
        format.html { render action: 'new' }
        format.json { render json: @excitement_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /excitement_pages/1
  # PATCH/PUT /excitement_pages/1.json
  def update
    respond_to do |format|
      if @excitement_page.update(excitement_page_params)
        format.html { redirect_to @excitement_page, notice: 'Excitement page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @excitement_page.errors, status: :unprocessable_entity }
      end
    end
  end

  def email_list
    client = ILF::RestForceClient.new
    @contacts = client.donors_since(Date.today - 3.month)
  end

  def send_email
    puts "**************   got here  #{params}"
    ExcitementPageMailer.sample_mail(params[:email_address],@excitement_page).deliver
    flash[:notice] = "The email has been sent"
    redirect_to email_list_excitement_page_path(@excitement_page)
  end

  # DELETE /excitement_pages/1
  # DELETE /excitement_pages/1.json
  def destroy
    @excitement_page.destroy
    respond_to do |format|
      format.html { redirect_to excitement_pages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_excitement_page
      @excitement_page = ExcitementPage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def excitement_page_params
      params.require(:excitement_page).permit(:title, :intro_text,:summary_text)
    end
end
