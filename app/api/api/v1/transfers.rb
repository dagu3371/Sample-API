module API::V1
  class Transfers < API::V1::Base

    resource :transfers do
      desc "Creates Transfer", {
          headers: @@USER_HEADERS,
          entity: API::Entities::Transfer
        }
        params do
          requires :account_number_from,        type: String,        desc: "Account Number From"
          requires :account_number_to,          type: String,        desc: "Account Number To"
          requires :amount_pennies,             type: Integer,       desc: "Amount of Pennies"
          requires :country_code_from,          type: String,        desc: "Country code from"
          requires :country_code_to,            type: String,        desc: "Country code to"
        end
        post do
          begin
            authenticate_user!
            @transfer = current_user.transfers.new(params)
            if @transfer.valid?
              @transfer.save
              present @transfer, with: API::Entities::Transfer
            else
              error!(@transfer.errors.full_messages, 422)
            end
          rescue => e
            error!([e], 422)
          end
        end
    end
  end
end
