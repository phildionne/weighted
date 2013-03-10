class ApplicationController < ActionController::Base
  protect_from_forgery

  private

    def assign_current_user
      @user = current_user
    end
end
