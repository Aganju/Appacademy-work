class UserMailer < ApplicationMailer
  default from: 'everybody@appacademy.io'

  def welcome_email(user)
    @user = user
    @url = 'http://localhost:3000/cats'
    mail(to: 'grend500@gmail.com', subject: 'Welcome to Cat Renting!')
  end
end
