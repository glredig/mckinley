class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection

  protect_from_forgery with: :null_session, if: proc { |c| c.request.format == 'application/json' }

  before_action :authenticate

  attr_reader :current_user
  helper_method :current_user

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      id = options[:id].presence
      user = id && User.where(id: id).first

      if user && User.secure_compare(user.auth_token, token)
        @current_user = user
      end
    end
  end
end
