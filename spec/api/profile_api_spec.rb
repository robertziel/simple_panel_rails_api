require 'spec_helper'

describe ProfileAPI do
  let(:headers) { {} }
  let(:params) { {} }

  let!(:user) { create(:user) }

  describe '#SHOW' do
    subject do
      get '/api/profile', params: params, headers: headers
    end

    include_context :should_check_valid_authentication_token

    it 'must return user data' do
      subject

      expect(response.status).to eq 200

      json = JSON.parse(response.body)
      expect(json['profile']).to eq user.slice(:email, :username)
    end
  end

  describe '#UPDATE' do
    let(:user_attributes) do
      {
        email: 'new@email.com',
        username: 'new_username',
        password: nil,
        password_confirmation: nil
      }
    end

    shared_examples :profile_update_succeeds do
      context 'succeeds' do
        it 'should be success' do
          subject
          expect(response.status).to eq 200
        end

        it 'should return new profile data' do
          subject

          json = JSON.parse(response.body)
          expect(json['profile']).to eq(
            user_attributes.except(:password, :password_confirmation).stringify_keys
          )
        end
      end
    end

    shared_examples :profile_update_failes do
      context 'failes' do
        it 'should not succeed' do
          subject
          expect(response.status).to eq 200
        end

        it 'should return error message' do
          subject
          json = JSON.parse(response.body)
          expect(json['error_messages']).not_to be_nil
        end
      end
    end

    subject do
      post '/api/profile', params: params.merge(user_attributes), headers: headers
    end

    include_context :should_check_valid_authentication_token

    include_examples :profile_update_succeeds

    context '#username is nil' do
      before do
        user_attributes[:username] = nil
      end
      include_examples :profile_update_failes
    end

    context '#password' do
      context 'passed' do
        before do
          user_attributes[:password] = '12345678'
        end

        context 'without confirmation' do
          include_examples :profile_update_failes
        end

        context 'with confirmation' do
          before do
            user_attributes[:password_confirmation] = user_attributes[:password]
          end
          include_examples :profile_update_succeeds
        end
      end
    end
  end
end
