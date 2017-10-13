class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  def index
    @users = User.all
  end
  def new
    @user = User.new
  end
  def show
    @user = User.find(params[:id])
  end
  # user_params from required private method below in place of params[:id]
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "User successfully created!"
      puts "USER SAVED"
      redirect_to @user
    else
      puts "USER DIDNT SAVE"
      render 'new'
    end
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "User updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  def edit
    @user = User.find(params[:id])
  end
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Log in to continue!"
        redirect_to login_url
      end
    end
    # Check to make sure only currently logged in user can edit/update posts
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user === current_user
    end
end
