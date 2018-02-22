module API
  module Entities
    class Transfer < Grape::Entity
      # Expose it wrapped in a data container for mobile team to parse easier
      root 'data', 'data'
      expose :account_number_from,              documentation: { type: 'String',  desc: 'Account Number From' }
      expose :account_number_to,                documentation: { type: 'String',  desc: 'Account Number To' }
      expose :amount_pennies,                   documentation: { type: 'String',  desc: 'Amount in Pennies' }
      expose :country_code_from,                documentation: { type: 'String',  desc: 'Country Code From' }
      expose :country_code_to,                  documentation: { type: 'String',  desc: 'Country Code To' }
    end
  end
end
