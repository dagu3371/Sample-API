require 'grape-swagger'

module API
  class Base < Grape::API

    prefix 'api'

    @@USER_HEADERS = {
      "X-User-Auth-Token" => {
        description: "Verify user",
        required: true
      }
    }

    require 'grape_logging'
    logger.formatter = GrapeLogging::Formatters::Default.new
    use GrapeLogging::Middleware::RequestLogger, { logger: logger }

    # Rescue from errors
    rescue_from ActiveRecord::RecordNotFound do |e|
      error!([e.message], 404)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      error!([e.message], 422)
    end

    rescue_from Grape::Exceptions::ValidationErrors do |e|
      error!(e.full_messages, 400)
    end

    # Catch all to ensure we don't return bad errors
    rescue_from :all do |e|
      # For development use
      error!("#{e.class.name}: #{e.message}")
      # For prod use
      # error!({ error: 'Server error.' }, 500, { 'Content-Type' => 'text/error' })
    end

    helpers do
      def authenticate_user!
        error!(["401 Unauthorized - Invalid Authentication Token"], 401) unless authenticated
      end

      def authenticated
        has_headers && has_auth_token &&
        Devise.secure_compare(@user.authentication_token, headers["X-User-Auth-Token"])
      end

      def current_user
        @user = User.where(authentication_token: headers["X-User-Auth-Token"]).last
      end

      private

      def has_headers
        headers["X-User-Auth-Token"]
      end

      def has_auth_token
        if User.where(authentication_token: headers["X-User-Auth-Token"]).present?
          @user = User.where(authentication_token: headers["X-User-Auth-Token"]).first
          return true
        else
          error!(["401 Unauthorized"], 401)
        end
      end

    end

    mount API::V1::Base

    add_swagger_documentation api_version: 'v1',
                              hide_documentation_path: true,
                              info: { title: 'Sample Api Docs' }
  end
end
