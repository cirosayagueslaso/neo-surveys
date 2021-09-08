module Api
  module V1
    class ApiController < ActionController::API
      include DeviseTokenAuth::Concerns::SetUserByToken
      include CorsSetHeaders

    end
  end
end
