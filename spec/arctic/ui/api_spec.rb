require "spec_helper"

RSpec.describe Arctic::UI::API do
  let(:username) { 'username' }
  let(:password) { 'password' }
  let(:instance) do
    token = double(token: 'abcdef123')
    expect_any_instance_of(described_class).to receive(:authenticate!).and_return token
    described_class.new username, password
  end

  describe '#new' do
    subject { instance }

    it { is_expected.to be_a described_class }
    it { expect(subject.connection).to be_a Faraday::Connection }
  end

  describe 'delegates get_ update_ and create_ prefixes to connection' do
    let(:json) { { a: :b }.as_json }
    let(:connection) { double }

    %w(get update create).each do |prefix|
      let(:method) { "#{prefix}_endpoint".to_sym }
      subject { instance.public_send(method, { c: :d }) }
      it do
        expect(instance).to receive(:method_missing).with(method, { c: :d }).and_return json
        is_expected.to eql(json)
      end
    end
  end
end
