class FrontpageController < ApplicationController

  # GET /
  def show

    if current_user

      @collections = current_user.followed_collections
      @contents = @collections.map(&:contents).flatten

      render 'homepage'
    else
      render 'frontpage'
    end
  end
end
