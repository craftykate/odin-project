class UserMailer < ActionMailer::Base
  default from: "noreply@example.com"

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account Activation"
  end

  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
