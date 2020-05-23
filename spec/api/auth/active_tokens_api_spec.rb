require 'spec_helper'

describe Auth::ActiveTokensAPI do
  let!(:user) { create(:user) }
  let!(:user_2) { create(:user) }
  let!(:active_token) { create(:authentication_token, user: user) }
  let(:headers) { {} }

  describe 'GET index' do
    let(:params) { {} }

    subject do
      get '/api/auth/active_tokens', headers: headers, params: params
    end

    include_context :should_check_valid_authentication_token

    include_context :should_have_pagination, :authentication_token, user: :user

    context 'authentication_token belongs to user' do
      it 'should be success' do
        subject
        expect(response.status).to eq 200
      end

      it 'returns authentication_token' do
        subject
        json = response_body_to_json
        expect(json[:authentication_tokens]).
          to eq serialize_collection(
            [active_token, authentication_token],
            serializer: Api::Auth::ActiveTokenSerializer
          )
      end
    end

    context 'authentication_token does not belong to user' do
      before do
        active_token.update!(user: user_2)
      end

      it 'should be success' do
        subject
        expect(response.status).to eq 200
      end

      it 'returns authentication_token' do
        subject
        json = response_body_to_json
        expect(json[:authentication_tokens]).to eq serialize_collection(
          [authentication_token], serializer: Api::Auth::ActiveTokenSerializer
        )
      end
    end
  end

  describe 'POST Expire tokens' do
    let(:params) { { ids: [active_token.id] } }

    subject do
      post '/api/auth/active_tokens', params: params, headers: headers
    end

    include_context :should_check_valid_authentication_token

    context 'authentication_token belongs to user' do
      it 'should be success' do
        subject
        expect(response.status).to eq 200
      end

      it 'expires authentication_token' do
        expect { subject }.to change { user.authentication_tokens.valid.count }.by(-1)

        json = response_body_to_json
        expect(json[:success]).to be true
      end
    end

    context 'authentication_token does not belong to user' do
      before do
        active_token.update!(user: user_2)
      end

      it 'does not expire any authentication_token' do
        expect do
          expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
        end.to change { AuthenticationToken.valid.count }.by(0)
      end
    end
  end
end
