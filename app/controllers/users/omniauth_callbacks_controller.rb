class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    auth = request.env["omniauth.auth"]
    @user = User.first_or_create_from_auth(auth)

    if @user.persisted?

      # Update User's Profile with provider informations on every authentication
      @user.profile.update_attributes_from_auth(auth.info)

      sign_in_and_redirect @user
    else
      session['devise.user_attributes'] = @user.attributes
      session['omniauth.info'] = auth.info
      redirect_to new_user_registration_url
    end
  end
  alias_method :twitter, :all

end
