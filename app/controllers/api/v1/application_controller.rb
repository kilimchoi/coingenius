module Api
  module V1
    class ApplicationController < ActionController::API
      include Api::Authentication::SignedRequest
    end
  end
end
