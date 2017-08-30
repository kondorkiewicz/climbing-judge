class UserMailer < ApplicationMailer
  default from: 'ociepkakonrad@gmail.com'
  
  def welcome_email(user)
    attachments.inline['tw-small.png'] = 
      File.read("#{Rails.root}/public/tw-small.png")
    @user = user 
    @url = 'https://climbing-judge.herokuapp.com/login'
    mail(to: @user.email, subject: 'Welcome to Climbing Judge')
  end 
end
