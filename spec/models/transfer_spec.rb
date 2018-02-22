require 'rails_helper'

RSpec.describe Transfer, type: :model do
  context "Account Number From Validations" do
    it { is_expected.to validate_presence_of(:account_number_from) }
    it { is_expected.to validate_length_of(:account_number_from) }
  end

  context "Account Number To Validations" do
    it { is_expected.to validate_presence_of(:account_number_to) }
    it { is_expected.to validate_length_of(:account_number_to) }
  end

  context "Amount of Pennies Validations" do
    it { is_expected.to validate_presence_of(:amount_pennies) }
    it { is_expected.to validate_numericality_of(:amount_pennies) }
  end

  context "Country Code From Validations" do
    it { is_expected.to validate_presence_of(:country_code_from) }
    it { is_expected.to validate_length_of(:country_code_from) }
  end

  context "Country Code To Validations" do
    it { is_expected.to validate_presence_of(:country_code_to) }
    it { is_expected.to validate_length_of(:country_code_to) }
  end
end
