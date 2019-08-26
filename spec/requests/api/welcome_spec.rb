require 'spec_helper'

describe API::Welcome do
  it 'should be success' do
    get '/api/welcome'

    expect(response.status).to eq 200

    json = JSON.parse(response.body)
    expect(json['title']).not_to be_nil
    expect(json['message']).not_to be_nil
  end
end
