class UserMailer < ApplicationMailer
  default from: 'aasthasaipanwar@gmail.com'
  
  def welcome_email
    @user=params[:user]
    mail(to: @user.email, subject: "Welcome to my Music App")
  end
  
end
