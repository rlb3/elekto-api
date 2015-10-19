require 'rspec_api_documentation_helper'

RSpec.resource 'Users' do
  header 'Content-Type', 'application/vnd.api+json'

  shared_context 'user parameters' do
    parameter 'type', <<-DESC, required: true
      The type of the resource. Must be users.
    DESC
    let 'type' do
      'users'
    end

    parameter 'name', <<-DESC, scope: :attributes, required: true
      The name of the user.
    DESC
    parameter 'mobile-phone-number', <<-DESC, scope: :attributes, required: true
      The mobile phone of the user.
    DESC
    parameter 'email', <<-DESC, scope: :attributes, required: true
      The email address of the user.
    DESC

    parameter 'password', <<-DESC, scope: :attributes, required: true
      The password for the user.
    DESC
  end

  post '/v1/users' do
    include_context 'user parameters'

    let 'name' do
      'Example User'
    end

    let 'email' do
      'asdf@example.com'
    end

    let 'password' do
      '12345678'
    end

    example_request 'POST /v1/users' do
      expect(status).to eq 201
      user = JSON.parse(response_body)
      expect(user['data']['attributes']['email']).to eq send('email')
    end
  end

  get '/v1/users/:id' do
    let! :persisted_user do
      FactoryGirl.create(:user)
    end

    let :id do
      persisted_user.id.to_s
    end

    example_request 'GET /v1/users/:id' do
      expect(status).to eq 200
    end
  end

  patch '/v1/users/:user_id' do
    let! :persisted_user do
      FactoryGirl.create(:user)
    end

    let 'user_id' do
      persisted_user.id.to_s
    end

    parameter 'id', <<-DESC, required: true
      The id of the user.
    DESC

    let :id do
      persisted_user.id.to_s
    end

    include_context 'user parameters'

    let 'name' do
      'Example User'
    end

    example_request 'PATCH /v1/users/:id' do
      expect(status).to eq 200
      user = JSON.parse(response_body)
      expect(user['data']['attributes']['name']).to eq public_send('name')
    end
  end

  get '/v1/users' do
    before do
      2.times do
        FactoryGirl.create(:user)
      end
    end
    example_request 'GET /v1/users' do
      expect(status).to eq 200
      users = JSON.parse(response_body)
      expect(users['data'].size).to eq 2
    end
  end
end
