class UserMailer < ActionMailer::Base
	default to: "archangelsofkyiv@gmail.com"
	default from: "archangelsofkyiv.info@gmail.com"

	def user_email(contact) 
    @contact = contact 
		mail(to: 'archangelsofkyiv@gmail.com', subject: 'Новий Запит!')
	end 	
end
