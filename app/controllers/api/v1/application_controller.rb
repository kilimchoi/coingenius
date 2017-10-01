module Api
  module V1
    class ApplicationController < ActionController::API
      include Api::Authentication::SignedRequest
      include Api::Authentication::SignedRequest::SkipOnDev
    end
  end
end
