class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::MimeResponds
  # include ActionController::ImplicitRender
  # include AbstractController::Callbacks
  # include ActionController::RequestForgeryProtection

  before_filter :authenticate_user_from_token!

  private

    def authenticate_user_from_token!
      authenticate_with_http_token do |token, options|
        email = options[:email].presence
        user  = email && User.find_by_email(email)

        if user && Devise.secure_compare(user.authentication_token, token)
          sign_in user, store: false
        end
      end
    end
end
