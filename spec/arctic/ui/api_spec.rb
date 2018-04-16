require "spec_helper"

RSpec.describe Arctic::UI::API do
  let(:token_instance) { double(token: 'abcdef') }
  let(:password_client) { double(get_token: token_instance) }
  let(:client) { double(password: password_client) }
  let(:username) { 'username' }
  let(:password) { 'password' }

  let(:instance) { described_class.new username, password }

  before do
    expect(OAuth2::Client).to receive(:new).and_return client
  end

  describe '#new' do
    subject { instance }
    it { is_expected.to be_a described_class }
    it { expect(subject.connection).to be_a Faraday::Connection }
  end

  describe '#get_<ENDPOINT>' do
    subject { instance.get_endpoint }
    let(:json) { { a: :b }.as_json }

    before do
      expect(instance).to receive(:method_missing).with(:get_endpoint).and_return json
    end

    it { is_expected.to eql(json) }
  end

  describe '#update_<ENDPOINT>' do
    subject { instance.update_endpoint(c: :d) }
    let(:json) { { c: :d }.as_json }

    before do
      expect(instance).to receive(:method_missing).with(:update_endpoint, c: :d).and_return json
    end

    it { is_expected.to eql(json) }
  end

  describe '#create_<ENDPOINT>' do
    subject { instance.create_endpoint(c: :d) }
    let(:json) { { c: :d }.as_json }

    before do
      expect(instance).to receive(:method_missing).with(:create_endpoint, c: :d).and_return json
    end

    it { is_expected.to eql(json) }
  end
end
