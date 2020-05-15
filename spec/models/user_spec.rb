require 'spec_helper'

describe User do
  let(:user_build) { build(:user) }

  describe 'validations' do
    subject { user_build }

    context '#email' do
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email) }
      it { should allow_value('right@email.com').for(:email) }
      it { should_not allow_value('wrong@email').for(:email) }
      it { should_not allow_value('wrong.email').for(:email) }
    end

    context '#password' do
      it { should validate_confirmation_of :password }
      it { should validate_length_of(:password).is_at_least(8) }
    end

    context '#username' do
      it { should_not validate_presence_of(:username).on(:create) }
      it { should validate_presence_of(:username).on(:update) }
      it { should validate_length_of(:username).is_at_least(5).on(:update) }

      it 'should not validate if username shorted than 5 but did not change' do
        user_build.email = 'user@gmail.com'
        user_build.save!
        expect(user_build).to be_valid
      end
    end
  end

  describe '#set_username' do
    context 'user is new' do
      it 'should set username as email prefix' do
        user_build.email = 'user@gmail.com'
        user_build.save!
        expect(user_build.username).to eq 'user'
      end
    end

    context 'user persisted' do
      it 'should not set new username' do
        user_build.email = 'user@gmail.com'
        user_build.save!
        user_build.email = 'new_user@gmail.com'
        user_build.save!
        expect(user_build.username).to eq 'user'
      end
    end
  end
end
