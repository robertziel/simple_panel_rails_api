require 'spec_helper'

describe AuthenticationToken do
  let!(:authentication_token) { create(:authentication_token) }
  let(:authentication_token_build) { build(:authentication_token) }

  describe '#set_token' do
    context 'record is new' do
      it 'should set new token' do
        expect(authentication_token.token).not_to be_nil
      end

      it 'should not duplicate existing token' do
        SecureRandom.stub(:hex) do
          SecureRandom.unstub(:hex)
          authentication_token.token
        end
        authentication_token_build.save!
      end
    end

    context 'record persisted' do
      it 'should not set a new token' do
        generated_token = authentication_token.token
        authentication_token.save!
        expect(authentication_token.token).to eq generated_token
      end
    end
  end
end
