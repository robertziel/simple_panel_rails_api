require 'spec_helper'

describe UsersAPI do
  let(:headers) { {} }
  let!(:user) { create(:user) }

  describe '#INDEX' do
    subject do
      get '/api/users', headers: headers
    end

    include_context :should_check_valid_authentication_token

    it 'must get index' do
      subject

      expect(response.status).to eq 200

      json = JSON.parse(response.body)
      expect(json).to eq [user.slice(:email, :id, :username)]
    end
  end

  describe '#SHOW' do
    subject do
      get "/api/users/#{user.id}", headers: headers
    end

    include_context :should_check_valid_authentication_token

    it 'must show user' do
      subject

      expect(response.status).to eq 200

      json = JSON.parse(response.body)
      expect(json).to eq user.slice(:email, :id, :username)
    end
  end
end
