class ApplicationController < ActionController::API
    include ActionController::Serialization
    include ActionController::HttpAuthentication::Token::ControllerMethods

    before_action :authenticate

    protected

    def authenticate
        authenticate_token || render_unauthorized
    end

    def authenticate_token
        authenticate_with_http_token do |token, options|
            return token == "f98e847a-03bc-43d3-8dfa-1f192902b15a"
        end
    end

    def render_unauthorized(realm = "Application")
        self.headers["WWW-Authenticate"] = %(Token realm="#{realm}")
        render json: 'Bad credentials', status: :unauthorized
    end
end
