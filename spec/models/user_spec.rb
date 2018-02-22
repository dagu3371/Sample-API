require 'rails_helper'

RSpec.describe User, type: :model do
  context "Email Validations" do
    it { is_expected.to validate_presence_of(:email) }
  end

  context "First Name Validations" do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_length_of(:first_name) }
  end

  context "Last Name Validations" do
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_length_of(:last_name) }
  end

  context "Address Validations" do
    it { is_expected.to validate_presence_of(:address_line_1) }
    it { is_expected.to validate_length_of(:address_line_1) }
  end

  context "DOB Validations" do
    it { is_expected.to validate_presence_of(:dob) }
  end
end
