require 'spec_helper'

describe CurrentUserAPI do
  let!(:user) { create(:user) }

  describe 'GET current_user' do
    let(:params) { {} }

    subject do
      get '/api/current_user', params: params
    end

    include_context :should_check_valid_authentication_token

    it 'should be success' do
      subject

      expect(response.status).to eq 200

      json = JSON.parse(response.body)
      expect(json['username']).not_to be_nil
    end
  end
end
