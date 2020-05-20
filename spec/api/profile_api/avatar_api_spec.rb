require 'spec_helper'

describe ProfileAPI::AvatarAPI do
  let(:headers) { {} }
  let(:params) { {} }

  let!(:user) { create(:user) }

  describe '#SHOW' do
    subject do
      get '/api/profile/avatar', params: params, headers: headers
    end

    include_context :should_check_valid_authentication_token

    it 'must return avatar' do
      subject

      expect(response.status).to eq 200

      json = JSON.parse(response.body)
      expect(json['avatar']).to eq user.decorate.avatar_or_default
    end
  end

  describe '#UPDATE' do
    let(:avatar) do
      Rack::Test::UploadedFile.new(
        File.join(Rails.root, 'spec', 'support', 'images', 'test.jpg')
      )
    end

    subject do
      post '/api/profile/avatar', params: { avatar: avatar }, headers: headers
    end

    include_context :should_check_valid_authentication_token

    it 'must return avatar' do
      subject

      expect(response.status).to eq 200

      json = JSON.parse(response.body)
      expect(json['avatar']).to eq user.decorate.avatar_or_default
    end
  end
end
