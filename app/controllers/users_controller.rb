class UsersController < ApplicationController
  before_filter :authenticate_user!, except: :show

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/followed_collections
  # GET /users/1/followed_collections.json
  def followed_collections
    @user = User.find(params[:id])
    @collections = @user.followed_collections

    respond_to do |format|
      format.html { render 'followed_collections' }
      format.json { render json: @collections }
    end
  end
end
