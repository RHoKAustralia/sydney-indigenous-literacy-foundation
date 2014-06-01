class CommunityProfilesController < ApplicationController
  before_action :set_community_profile, only: [:show, :edit, :update, :destroy]

  def index
    @community_profiles = CommunityProfile.all
  end

  def show
  end

  def new
    @community_profile = CommunityProfile.new
  end

  def edit
  end

  def update
    respond_to do |format|
      if @community_profile.update(community_profile_params)
        format.html { redirect_to @community_profile, notice: 'Community profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @community_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def load_communities
    ILF::SalesForceService.load_communities
    redirect_to community_profiles_path
  end

  private
    def set_community_profile
      @community_profile = CommunityProfile.find(params[:id])
    end

    def community_profile_params
      params.require(:community_profile).permit(:bio)
    end
end
