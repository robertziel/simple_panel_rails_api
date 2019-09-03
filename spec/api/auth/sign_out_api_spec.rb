require 'spec_helper'

describe Auth::SignOutAPI do
  let!(:user) { create(:user) }

  describe 'GET current_user' do
    let(:headers) { {} }

    subject do
      delete '/api/auth/sign_out', headers: headers
    end

    include_context :should_check_valid_authentication_token

    it 'should be success' do
      subject

      expect(response.status).to eq 200

      json = JSON.parse(response.body)
      expect(json['success']).to be true
    end

    it 'should make authentication_token invalid' do
      expect { subject }.to change { user.authentication_tokens.valid.count }.by(-1)
    end
  end
end
