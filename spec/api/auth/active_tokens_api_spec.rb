require 'spec_helper'

describe Auth::ActiveTokensAPI do
  let!(:user) { create(:user) }
  let!(:active_token) { create(:authentication_token) }

  describe 'GET current_user' do
    let(:headers) { {} }

    subject do
      get '/api/auth/active_tokens', headers: headers
    end

    include_context :should_check_valid_authentication_token

    context 'authentication_token belongs to user' do
      before do
        active_token.update!(user: user)
      end

      it 'should be success' do
        subject
        expect(response.status).to eq 200
      end

      it 'returns authentication_token' do
        subject
        json = response_body_to_json
        expect(json[:active_tokens]).
          to eq serialize_collection(
            [authentication_token, active_token], serializer: Api::Auth::ActiveTokenSerializer
          )
      end
    end

    context 'authentication_token does not belong to user' do
      it 'should be success' do
        subject
        expect(response.status).to eq 200
      end

      it 'returns authentication_token' do
        subject
        json = response_body_to_json
        expect(json[:active_tokens]).to eq serialize_collection(
          [authentication_token], serializer: Api::Auth::ActiveTokenSerializer
        )
      end
    end
  end
end
