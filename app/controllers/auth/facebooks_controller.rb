module Auth
  class FacebooksController < ApplicationController
    skip_before_action :authenticate

    def create
      result = if new_user?
                 FacebookSignUp.perform(token: token_param)
               else
                 FacebookSignIn.perform(token: token_param)
               end

      if result.success?
        render json: result.user, serializer: CurrentUserSerializer, status: :ok
      else
        render json: { errors: result.errors }, status: :unprocessable_entity
      end
    end

    private

    def token_param
      params.require(:facebook).require(:token)
    end

    def new_user?
      facebook_json = Facebook.user_json(token_param)
      facebook_user_id = facebook_json.fetch('id') do
        fail 'Missing Facebook id from Facebook user_json call'
      end
      Facebook.where(provider_user_id: facebook_user_id).count == 0
    end
  end
end
