require 'spec_helper'

describe WelcomeController do
  render_views

  it 'should get index' do
    get :index
    expect(response.status).to eq 200
  end
end
