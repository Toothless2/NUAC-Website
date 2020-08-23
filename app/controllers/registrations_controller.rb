class RegistrationsController < Devise::RegistrationsController
    before_action :can_sign_up
    prepend_before_action :check_captcha, only: [:create]

    private
    def can_sign_up
        if Signup.first == nil || Signup.first.enabled == true
            return
        end

        redirect_to request.referer
    end

    def check_captcha
        unless verify_recaptcha
          self.resource = resource_class.new sign_up_params
          resource.validate # Look for any other validation errors besides reCAPTCHA
          set_minimum_password_length
          respond_with_navigational(resource) { render :new }
        end 
    end

    def sign_up_params
        val = params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
        val[:role] = Role.find_by(name: 'user')

        return val
    end

    def account_update_params
        params.require(:user).permit(:name, :username, :email, :password, :password_confirmation, :current_password)
    end
end