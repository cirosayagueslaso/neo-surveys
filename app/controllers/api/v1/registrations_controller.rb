module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      def create
        @resource = User.new(sign_up_params)

        unless @resource.save
          render json: { message: @resource.errors.full_messages.join(', ') }, status: :bad_request
          return
        end

        @token = @resource.create_token
        @resource.save

        update_auth_header
        render_create_success
      end

      private

      def sign_up_params
        params.permit(:name, :email, :password, :password_confirmation)
      end
    end
  end
end
