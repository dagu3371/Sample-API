require 'rails_helper'

describe API::V1::Transfers, type: :request do
  let!(:user)         { create(:user) }

  describe 'POST /api/transfers/' do

    context 'Create a new transfer' do
      context 'with valid params' do
        before do
          post "/api/transfers", headers: {'X-User-Auth-Token' => user.authentication_token}, params: { account_number_from: 123123123123123123, account_number_to: 123123123123123123, amount_pennies: 12, country_code_from: "AUS", country_code_to: "USA" }
        end

        it 'POST request should be successful' do
          expect(response).to be_success
        end
      end

      context 'with invalid account number from' do
        before do
          post "/api/transfers", params: { account_number_from: 123123123123123123, account_number_to: 12312312312312312, amount_pennies: 12, country_code_from: "AUS", country_code_to: "USA" }
        end

        it 'POST request should return 401' do
          expect(response.status).to eq 401
        end
      end
    end
  end
end
