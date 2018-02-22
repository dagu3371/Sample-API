FactoryGirl.define do
  factory :transfer do
    user
    account_number_from {"123123123123123123"}
    account_number_to   {"123123123123123123"}
    amount_pennies      {5}
    country_code_to     {"AUS"}
    country_code_from   {"USA"}
  end
end
