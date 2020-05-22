require 'spec_helper'

describe WelcomeAPI do
  let(:headers) { {} }

  before do
    class RootAPI
      mount DumbApiEndpoint
    end
  end

  subject do
    get '/api/dumb', headers: headers
  end

  describe '#ApiLocaleConcerns' do
    shared_examples :should_switch_locale_to do |locale|
      it "should have locale #{locale}" do
        subject

        json = response_body_to_json
        expect(json[:locale]).to eq locale.to_s
      end
    end

    context 'when no locale set in header' do
      include_examples :should_switch_locale_to, I18n.default_locale
    end

    context 'when locale set in header' do
      before do
        headers.merge! LANGUAGE_LOCALE_HEADER => :pl
      end

      include_examples :should_switch_locale_to, :pl

      it 'should reset locale after action' do
        subject

        expect(I18n.locale).to eq I18n.default_locale
      end
    end
  end
end
