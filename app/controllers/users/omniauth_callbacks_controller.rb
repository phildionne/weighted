class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    auth = request.env["omniauth.auth"]

    @user = User.first_or_create_from_auth(auth)

    if @user.persisted?

      @user.profile.update_attributes_from_auth(auth) if @user.new_record?

      sign_in_and_redirect @user
    else
      session['devise.user_attributes'] = @user.attributes
      session['omniauth.info'] = auth.info
      redirect_to new_user_registration_url
    end
  end
  alias_method :twitter, :all

end
