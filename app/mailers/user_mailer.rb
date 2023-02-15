class UserMailer < ActionMailer::Base
	default to: ENV["MAILER_SMTP_ADDRESS"]
	default from: ENV["MAILER_SMTP_USER_NAME"]

	def user_email(contact) 
    @contact = contact 
		mail(to: ENV["MAILER_SMTP_ADDRESS"], subject: 'Новий Запит!')
	end 	
end
