class SessionsController < ApplicationController
	def new
	end

	def create
		# Nested sessions hash does not exist when using form_tag to structure forms. 
		# The sessions has exist when using the form_for method.
		user = User.find_by(email: params[:email].downcase)
		if user && user.authenticate(params[:password])
			# Sign the user in and redirect to previous request or profile page.
			sign_in user
			redirect_back_or user 
		else
			# Create an error message re-render the signin form.
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end
end
