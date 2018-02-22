module API::V1
  class Users < API::V1::Base

    resource :users do

      desc "Creates a new user", entity: API::Entities::User
      params do
        requires :first_name,           type: String, desc: "First Name"
        requires :last_name,            type: String, desc: "Last Name"
        requires :email,                type: String, desc: "Email"
        requires :address_line_1,       type: String, desc: "Address"
        requires :dob,                  type: Date,   desc: "DOB"
        requires :password,             type: String, desc: "Password"
      end

      post do
        user = User.new(params)

        if user.save
          present user, with: API::Entities::User
        else
          error!(user.errors.full_messages, 422)
        end
      end

      desc "Signs in a user", entity: API::Entities::User
      params do
        requires :email, type: String, desc: "Email"
        requires :password, type: String, desc: "Password"
      end

      post 'login' do
        user = User.find_by_email(params[:email].downcase.strip)
        error!(["Incorrect Email/Password"], 401) unless user.present? && user.valid_password?(params[:password])
        user.regenerate_authentication_token
        present user.authentication_token
      end

      desc "Gets current user details", {
        headers: {
          "X-User-Auth-Token" => {
          description: "Verify user",
          required: true }
        }
      }
      get do
        if has_auth_token
          present @user, with: API::Entities::User
        end
      end

      desc "Updates the current user", {
        headers: @@USER_HEADERS
      }
      params do
        optional :first_name,           type: String, desc: "First Name"
        optional :last_name,            type: String, desc: "Last Name"
        optional :email,                type: String, desc: "Email"
        optional :address_line_1,       type: String, desc: "Address"
        optional :dob,                  type: Date,   desc: "DOB"
      end

      put do
        authenticate_user!
        current_user.update_attributes(params)
        present current_user, with: API::Entities::User
      end

      resource :transfers do
        route_param :transfer_id do
          desc "Deletes a transfer for the user", {
            headers: @@USER_HEADERS,
            entity: API::Entities::Transfer
          }

          delete do
            @transfer = current_user.transfers.find_by(id: params[:transfer_id])
            error!(["404 Can't find Transfer"], 404) unless @transfer.present?
            @transfer.destroy
          end

          desc "Updates a transfer for the user", {
            headers: @@USER_HEADERS,
            entity: API::Entities::Transfer
          }

          params do
            optional :account_number_from,        type: String,        desc: "Account Number From"
            optional :account_number_to,          type: String,        desc: "Account Number To"
            optional :amount_pennies,             type: Integer,       desc: "Amount of Pennies"
            optional :country_code_from,          type: String,        desc: "Country code from"
            optional :country_code_to,            type: String,        desc: "Country code to"
          end

          put do
            @transfer = current_user.transfers.find_by(id: params[:transfer_id])
            error!(["404 Can't find Transfer"], 404) unless @transfer.present?
            if @transfer.update(declared_params(params))
              present @transfer, with: API::Entities::Transfer
            else
              error!(@transfer.errors.full_messages, 422)
            end
          end
        end
      end

      resource :transfers do
        desc "Get user transfers", {
          headers: @@USER_HEADERS,
          entity: API::Entities::Transfer
        }

          get do
            begin
              present current_user.transfers, with: API::Entities::Transfer
            rescue => e
              error!([e], 422)
            end
          end
        end
    end
  end
end
