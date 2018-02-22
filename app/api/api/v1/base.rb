module API::V1
  class Base < API::Base
    version 'v1', using: :header, vendor: 'Sample App'

    format :json
    formatter :json, Grape::Formatter::ActiveModelSerializers

    helpers do
      def declared_params(params)
        declared(params, include_missing: false)
      end
    end

    mount API::V1::Users
    mount API::V1::Transfers
  end
end
