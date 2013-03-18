class ApplicationController < ActionController::Base
  protect_from_forgery

  private

    def assign_current_user
      @user = current_user
    end

    def load_collection
      @collection = Collection.find_by_id(params[:collection_id])
    end
end
