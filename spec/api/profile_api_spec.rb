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

  describe '#UPDATE' do
    let(:user_attributes) do
      { email: 'new@email.com', username: 'new_username' }
    end

    subject do
      post '/api/profile', params: params.merge(user_attributes), headers: headers
    end

    include_context :should_check_valid_authentication_token

    context 'succeeded' do
      it 'should be success' do
        subject
        expect(response.status).to eq 200
      end

      it 'should return new profile data' do
        subject

        json = JSON.parse(response.body)
        expect(json['profile']).to eq(user_attributes.stringify_keys)
      end
    end

    context 'did not succeeded' do
      before do
        user_attributes[:username] = nil
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
