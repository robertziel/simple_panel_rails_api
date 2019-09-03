require 'spec_helper'

describe AuthenticationToken do
  let!(:authentication_token) { create(:authentication_token) }
  let(:authentication_token_build) { build(:authentication_token) }

  describe 'scopes' do
    describe '#valid' do
      subject do
        described_class.valid.count
      end

      context 'when expires_at is in the future' do
        before do
          authentication_token.update_columns(expires_at: Time.zone.now + 1.day)
        end

        it 'should return the record' do
          expect(subject).to eq 1
        end
      end

      context 'when expires_at is in the past' do
        before do
          authentication_token.update_columns(expires_at: Time.zone.now)
        end

        it 'should not return the record' do
          expect(subject).to eq 0
        end
      end
    end
  end

  describe '#expire!' do
    it 'should change expires at to now' do
      expires_at = authentication_token.expires_at
      authentication_token.expire!
      expect(authentication_token.expires_at).not_to eq expires_at
    end
  end

  describe '#set_expires_at' do
    context 'record is new' do
      it 'should set expires at' do
        expect(authentication_token.expires_at).not_to be_nil
      end
    end

    context 'record persisted' do
      it 'should not change expires at' do
        expires_at = authentication_token.expires_at
        authentication_token.save!
        expect(authentication_token.expires_at).to eq expires_at
      end
    end
  end

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
        expect(authentication_token_build.token).
          not_to eq authentication_token.token
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
