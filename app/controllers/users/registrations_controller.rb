module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters

    private

    # Skip password confirmation on user account update
    def update_resource(resource, params)
      resource.update_without_password(params)
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(
        :sign_up,
        keys: %i(username)
      )

      devise_parameter_sanitizer.permit(
        :account_update,
        keys: %i(bittrex_api_key bittrex_api_secret username)
      )
    end
  end
end
