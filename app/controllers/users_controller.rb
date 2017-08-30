class UsersController < ApplicationController
  def new
    @user = User.new 
  end 
  
  def create 
    @user = User.new(user_params)
    if @user.save 
      session[:user_id] = @user.id
      UserMailer.welcome_email(@user).deliver_later
      redirect_to root_url, info: "Thank you for signing up! Email has been sent to you.
       Please check your inbox and follow the instructions."
    else 
      render "new"
    end 
  end 
  
  private 
  
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
  
end
