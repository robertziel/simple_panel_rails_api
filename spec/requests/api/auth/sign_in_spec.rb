require 'spec_helper'

describe API::Auth::SignIn do
  let!(:user) { create(:user) }

  describe 'POST sign_in' do
    let(:sign_in_attrs) do
      { email: user.email, password: user.password }
    end

    subject do
      post '/api/auth/sign_in', params: sign_in_attrs
    end

    context 'succeeded' do
      it 'should be success' do
        subject
        expect(response.status).to eq 200
      end

      it 'should return new authentication token' do
        expect { subject }.to change(user.authentication_tokens, :count)

        json = JSON.parse(response.body)
        expect(
          json['authentication_token']
        ).to eq(
          user.authentication_tokens.last.token
        )
      end
    end

    context 'did not succeeded' do
      before do
        sign_in_attrs[:password] = 'wrong_password'
      end

      it 'should be unauthorized' do
        subject
        expect(response.status).to eq 401
      end

      it 'should return error message' do
        subject
        json = JSON.parse(response.body)
        expect(json['error_message']).not_to be_nil
      end
    end
  end
end
