require 'rspec_api_documentation_helper'

RSpec.resource 'Elections' do
  header 'Content-Type', 'application/vnd.api+json'

  shared_context 'election parameters' do
    parameter 'type', <<-DESC, required: true
      The type of the resource. Must be elections.
    DESC
    let 'type' do
      'elections'
    end

    parameter 'name', <<-DESC, scope: :attributes, required: true
      The name of the election.
    DESC
    parameter 'start-at', <<-DESC, scope: :attributes, required: true
      Start of the Election
    DESC
    parameter 'end-at', <<-DESC, scope: :attributes, required: true
      End of the Elections
    DESC
  end

  post '/v1/elections' do
    include_context 'election parameters'

    let 'name' do
      'Example Election'
    end

    let 'start-at' do
      Time.zone.now
    end

    let 'end-at' do
      1.week.from_now
    end

    example_request 'POST /v1/elections' do
      expect(status).to eq 201
      election = JSON.parse(response_body)
      expect(election['data']['attributes']['name']).to eq public_send('name')
    end
  end

  get '/v1/elections/:id' do
    let! :persisted_election do
      FactoryGirl.create(:election)
    end

    let :id do
      persisted_election.id.to_s
    end

    example_request 'GET /v1/elections/:id' do
      expect(status).to eq 200
    end
  end

  patch '/v1/elections/:election_id' do
    let! :persisted_election do
      FactoryGirl.create(:election)
    end

    let 'election_id' do
      persisted_election.id.to_s
    end

    parameter 'id', <<-DESC, required: true
      The id of the election.
    DESC

    let :id do
      persisted_election.id.to_s
    end

    include_context 'election parameters'

    let 'name' do
      'Example Election'
    end

    example_request 'PATCH /v1/elections/:id' do
      expect(status).to eq 200
      election = JSON.parse(response_body)
      expect(election['data']['attributes']['name']).to eq public_send('name')
    end
  end

  get '/v1/elections' do
    before do
      2.times do
        FactoryGirl.create(:election)
      end
    end
    example_request 'GET /v1/elections' do
      expect(status).to eq 200
      elections = JSON.parse(response_body)
      expect(elections['data'].size).to eq 2
    end
  end
end
