class ApplicationMailer < ActionMailer::Base
  default from: ENV['GMAIL_USERNAME_DEV']
end