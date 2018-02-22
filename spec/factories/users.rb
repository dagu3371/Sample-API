FactoryGirl.define do
  factory :user do
    first_name          { "David" }
    last_name           { "Gu" }
    email               { "test@test.com" }
    dob                 { '12-12-1990' }
    address_line_1      {"123 Fake Street"}
    password            {"password"}
  end
end
