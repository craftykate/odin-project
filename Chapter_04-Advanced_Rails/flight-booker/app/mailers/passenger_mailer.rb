class PassengerMailer < ApplicationMailer

	def thank_you_email(booking)
		@booking = booking
		@user = @booking.passengers.first
		mail(to: @user.email, subject: "Your flight confirmation")
	end
end
