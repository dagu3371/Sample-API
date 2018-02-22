require 'rails_helper'

describe API::V1::Users, type: :request do
  describe 'PUT /api/users/' do
    let!(:user)     { create(:user) }

    context 'Updates the current user' do
      before do
        put "/api/users", headers: {'X-User-Auth-Token' => user.authentication_token}, params: {email: 'test@gmail.com'}
      end

      it 'PUT request should be successful' do
        expect(response).to be_success
      end

      it 'Correct user email should be returned' do
        expect(JSON.parse(response.body)['data']['email']).to eq 'test@gmail.com'
      end
    end
  end

  describe 'POST /api/users/' do

    context 'Create a new user' do
      context 'with valid params' do
        before do
          post "/api/users", params: { email: 'test@test.com', password: 'password', first_name: "David", last_name: "Gu", address_line_1: "123 Fake Street", dob: "12-12-2000" }
        end

        it 'POST request should be successful' do
          expect(response).to be_success
        end
      end

      context 'with invalid params' do
        before do
          post "/api/users", params: { email: 'test@test.com', password: 'password', role: 'foo' }
        end

        it 'POST request should return 400' do
          expect(response.status).to eq 400
        end
      end

      context 'with first name longer than 20 char' do
        before do
          post "/api/users", params: { email: 'test@test.com', password: 'password', first_name: "DavidaaaaaDavidaaaaaDavidaaaaa", last_name: "Gu", address_line_1: "123 Fake Street", dob: "12-12-2000" }
        end

        it 'POST request should return 422' do
          expect(response.status).to eq 422
        end
      end

      context 'with last name longer than 20 char' do
        before do
          post "/api/users", params: { email: 'test@test.com', password: 'password', first_name: "David", last_name: "DavidaaaaaDavidaaaaaDavidaaaaa", address_line_1: "123 Fake Street", dob: "12-12-2000" }
        end

        it 'POST request should return 422' do
          expect(response.status).to eq 422
        end
      end

    end

    describe 'PUT /api/users/transfers' do
      let!(:user)         { create(:user) }
      let!(:transfer)     { create(:transfer, user: user) }

      context 'Updates a user transfer' do
        before do
          put "/api/users/transfers/#{transfer.id}", headers: {'X-User-Auth-Token' => user.authentication_token}, params: {amount_pennies: 99, transfer_id: transfer.id}
        end

        it 'PUT request should be successful' do
          expect(response).to be_success
        end

        it 'Correct transfer email should be returned' do
          expect(JSON.parse(response.body)['data']['amount_pennies']).to eq 99
        end
      end
    end
  end
end
