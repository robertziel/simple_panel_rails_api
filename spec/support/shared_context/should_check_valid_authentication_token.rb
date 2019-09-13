shared_context :should_check_valid_authentication_token do
  let(:authentication_token) { create(:authentication_token, user: user) }
  let(:token) { authentication_token.token }

  before do
    headers.merge! AUTHENTICATION_TOKEN_HEADER => token
  end

  context 'when invalid authentication_token' do
    shared_examples :should_not_be_authorized do
      it 'should be unauthorized' do
        subject

        expect(response.status).to eq 401

        json = JSON.parse(response.body)
        expect(json['error']).not_to be_nil
      end
    end

    context 'when token does not exist' do
      let(:token) { nil }

      include_examples :should_not_be_authorized
    end

    context 'when token is expired' do
      before do
        authentication_token.update_columns(expires_at: Time.zone.now)
      end

      include_examples :should_not_be_authorized
    end
  end
end
