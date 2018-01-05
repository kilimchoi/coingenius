module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters

    private

    # Skip password confirmation on user account update
    def update_resource(resource, params)
      resource.update_with_password(params)
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(
        :sign_up,
        keys: %i[username]
      )

      devise_parameter_sanitizer.permit(
        :account_update,
        keys: account_update_attributes
      )
    end

    def account_update_attributes
      user_api_attributes + user_standard_attributes
    end

    def user_api_attributes
      %i[binance_api_key binance_api_secret bittrex_api_key bittrex_api_secret]
    end

    def user_standard_attributes
      %i[username password password_confirmation current_password]
    end
  end
end
