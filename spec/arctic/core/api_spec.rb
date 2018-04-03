require "spec_helper"
require 'webmock/rspec'

RSpec.describe Arctic::Core do
  before do
    Arctic::Core.configure do |c|
      c.token = 'Hello'
    end
  end

  describe 'get' do
    subject { Arctic::Core.get 'somewhere', params: { a: :b } }
    let!(:stub) do
      stub_request(
        :get,
        "http://localhost:5000/api/v1/somewhere?a=b&access_token=Hello")
      .to_return(
        status: 200)
    end

    it 'correctly calls the API' do
      subject
      expect(stub).to have_been_requested
    end
  end

  describe 'post' do
    subject { Arctic::Core.post 'somewhere', json: { a: :b }, params: { c: :d } }
    let!(:stub) do
      stub_request(
        :post,
        "http://localhost:5000/api/v1/somewhere?access_token=Hello&c=d")
      .with(
        body: { a: :b }.to_json)
      .to_return(
        status: 200)
    end

    it 'correctly calls the API' do
      subject
      expect(stub).to have_been_requested
    end
  end
end
