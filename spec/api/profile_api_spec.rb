require 'spec_helper'

describe ProfileAPI do
  let(:headers) { {} }
  let(:params) { {} }

  let!(:user) { create(:user) }

  describe '#INDEX' do
    subject do
      get '/api/profile', params: params, headers: headers
    end

    include_context :should_check_valid_authentication_token

    it 'must get index' do
      subject

      expect(response.status).to eq 200

      json = JSON.parse(response.body)
      expect(json['profile']).to eq user.slice(:email, :username)
    end
  end
end
