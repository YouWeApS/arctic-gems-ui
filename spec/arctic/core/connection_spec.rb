require "spec_helper"
require 'webmock/rspec'

RSpec.describe Arctic::Core::Connection do
  before do
    Arctic::Core.configure do |c|
      c.token = 'Hello'
    end
  end

  describe 'get' do
    subject { Arctic::Core::Connection.get 'somewhere', params: { a: :b } }
    let!(:stub) do
      stub_request(
        :get,
        "http://localhost:5000/api/v1/somewhere?a=b")
      .to_return(
        status: 200)
    end

    it 'correctly calls the API' do
      subject
      expect(stub).to have_been_requested
    end
  end

  describe 'post' do
    subject { Arctic::Core::Connection.post 'somewhere', json: { a: :b }, params: { c: :d } }
    let!(:stub) do
      stub_request(
        :post,
        "http://localhost:5000/api/v1/somewhere?c=d")
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
