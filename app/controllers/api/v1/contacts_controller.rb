class Api::V1::ContactsController < ApplicationController
  before_action :check_admin, only: [:destroy, :update]
  
  def new
    @contact = Contact.new
  end

	def create
    @contact = Contact.new(contact_params)

    if @contact.save
      UserMailer.user_email(@contact).deliver_now
			render json: {
				message: 'Ваше звернення успішно відправлено! 
				Ми розглянемо його найближчим часом і надішлемо свою відповідь на ваш E-Mail' 
			}
    else
      render json: @contact.errors
    end
  end

	private
	def contact_params
    params.require(:contact).permit(:name, :email, :phone, :message)
  end
end