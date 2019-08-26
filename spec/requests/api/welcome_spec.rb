require 'spec_helper'

describe API::Welcome do
  it 'should be success' do
    get '/api/welcome'

    expect(response).to be_success

    json = response.body.to_json
    expect(json['title']).not_to be_nil
    expect(json['message']).not_to be_nil
  end
end
