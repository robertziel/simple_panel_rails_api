require 'spec_helper'

describe WelcomeAPI do
  it 'should be success' do
    get '/api/welcome'

    expect(response.status).to eq 200

    json = response_body_to_json
    expect(json[:title]).not_to be_nil
    expect(json[:message]).not_to be_nil
  end
end
