require 'spec_helper'

RSpec.describe 'OAuth password flow' do

  let :email do
    'asdf@example.com'
  end

  let :password do
    'asdffdsa'
  end

  let! :user do
    FactoryGirl.create(:user, email: email, password: password)
  end

  it 'creates a token and returns it when the credentials are valid' do
    post '/oauth/token', grant_type: 'password', username: email, password: password
    expect(response.status).to eq 200

    access_token = JSON.parse(response.body)['access_token']
    expect(access_token).not_to be_nil
  end

  it 'does not issue a token if the credentials are invalid' do
    post '/oauth/token', grant_type: 'password', username: email, password: 'fdsafdsa'
    expect(response.status).to eq 401
  end
end
