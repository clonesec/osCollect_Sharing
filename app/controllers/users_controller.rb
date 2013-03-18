class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.order("updated_at desc").page(params[:page]).per_page(12)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to users_url, :notice => "Admin user was successfully created."
    else
      render action: "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to users_url, notice: "Admin user #{@user.username} was updated."
    else
      render action: "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.username.strip.downcase == 'admin'
      flash[:error] = "Deleting the default admin account is not allowed."
      redirect_to users_url
      return 
    end
    if @user.id == current_user.id
      flash[:error] = "Deleting your own account is not allowed."
      redirect_to users_url
      return 
    end
    @user.destroy
    redirect_to users_url, notice: "Admin user #{@user.username} was deleted."
  end
end
