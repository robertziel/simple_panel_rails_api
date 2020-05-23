shared_context :should_check_valid_authentication_token do
  let(:authentication_token) { create(:authentication_token, user: user) }
  let(:token) { authentication_token.token }

  before do
    headers.merge! AUTHENTICATION_TOKEN_HEADER => token
  end

  context '#authentication' do
    context 'when invalid authentication_token' do
      shared_examples :should_not_be_authorized do
        it 'should be unauthorized' do
          subject

          expect(response.status).to eq 401

          json = response_body_to_json
          expect(json[:error]).not_to be_nil
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

    it 'touches last_used_at' do
      datetime_before_request = authentication_token.reload.last_used_at
      subject
      expect(authentication_token.reload.last_used_at).not_to eq datetime_before_request
    end

    it "should mark #{AUTHENTICATION_TOKEN_HEADER} header as required in documentation" do
      subject
      doc_headers = response.request.env['grape.routing_args'][:route_info].headers
      expect(doc_headers['Authentication-Token']).not_to be_nil
    end
  end
end
