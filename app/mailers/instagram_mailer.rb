# frozen_string_literal: true

class InstagramMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.instagram_mailer.story_create.subject
  #
  def story_create
    @user = params[:user]

    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
