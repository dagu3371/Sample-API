module API
  module Entities
    class User < Grape::Entity
      # Expose it wrapped in a data container for mobile team to parse easier
      root 'data', 'data'
      expose :name do |user, options|
        user.full_name
      end
      expose :age do |user, options|
        user.age
      end
      expose :email,                documentation: { type: 'String',  desc: 'Users email' }
      expose :address_line_1,       documentation: { type: 'String', desc:  'Address' }
    end
  end
end
