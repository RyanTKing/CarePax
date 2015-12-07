class UsersController < ApplicationController
  include SessionsHelper

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'Thanks for registering for CarePax!'
      render :json => { :success => [order_path] }
    else
      render :json => { :errors => @user.errors }
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :city, :gender, :dob, :bio)
  end
end
