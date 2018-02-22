class Transfer < ApplicationRecord
  belongs_to :user
  validates :account_number_from,  presence: true, length: { is: 18 }
  validates :account_number_to,  presence: true, length: { is: 18 }
  validates :amount_pennies,  presence: true, numericality: { greater_than: 0 }
  validates :country_code_from,  presence: true, length: { is: 3 }, format: {:with => /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/ }
  validates :country_code_to,  presence: true, length: { is: 3 }, format: {:with => /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/ }

end
