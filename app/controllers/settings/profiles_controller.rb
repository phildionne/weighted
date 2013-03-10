class Settings::ProfilesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :assign_current_user

  # GET /settings/profile
  # GET /settings/profile.json
  def show
    @profile = Profile.find_by_user_id(@user)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @profile }
    end
  end

  # GET /settings/profile/edit
  def edit
    @profile = Profile.find_by_user_id(@user)
  end

  # PUT /settings/profile
  # PUT /settings/profile.json
  def update
    @profile = Profile.find_by_user_id(@user)

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to settings_profile_path, notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end
end
