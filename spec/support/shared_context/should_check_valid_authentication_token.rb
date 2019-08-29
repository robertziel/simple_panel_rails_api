shared_context :should_check_valid_authentication_token do
  let(:authentication_token) { create(:authentication_token, user: user) }
  let(:token) { authentication_token.token }

  before do
    params.merge!(authentication_token: token)
  end

  context 'when invalid authentication_token' do
    let(:token) { 'wrong_token' }

    it 'should be unauthorized' do
      subject

      expect(response.status).to eq 401

      json = JSON.parse(response.body)
      expect(json['error']).not_to be_nil
    end
  end
end
