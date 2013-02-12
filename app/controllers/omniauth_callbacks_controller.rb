class OmniauthCallbacksController < ApplicationController
  def all
    auth = request.env["omniauth.auth"]

    @user = User.first_or_create_from_auth(auth)

    if @user.persisted?
      # flash[:success] = "Signed in!"
      sign_in_and_redirect @user
    else
      session["devise.user_attributes"] = @user.attributes
      redirect_to new_user_registration_url
    end
  end
  alias_method :twitter, :all

end
