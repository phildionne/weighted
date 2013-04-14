class Users::RegistrationsController < Devise::RegistrationsController

  # POST /users
  def create
    resource = super

    # Populate User's Profile with provider informations on User creation
    if @user.persisted? && session.has_key?('omniauth.info')
      @user.profile.update_attributes_from_auth(session['omniauth.info'])
    end

    resource
  end
end
