require "spec_helper"

RSpec.describe Arctic::UI::API do
  let(:instance) { described_class.new username, password }
  let(:username) { 'eshoes@email.com' }
  let(:password) { 'password' }

  describe 'shops endpoint' do
    describe '#get_shops' do
      let(:response_json) { instance.get_shops.deep_symbolize_keys }

      it "returns a list of the account's shops" do
        VCR.use_cassette('get_shops') do
          expect(response_json).to eql([
            {
              id: "8e25477b-8cb3-4707-a304-599097ee5aa2",
              name: "DK shop",
            },
          ])
        end
      end
    end
  end

  describe 'account endpoint' do
    describe '#update_account' do
      let(:response_json) { instance.update_account(name: 'New Account Name').deep_symbolize_keys }

      it 'returns updates the account json' do
        VCR.use_cassette('update_account') do
          expect(response_json).to eql({
            id: "10a6e55e-a89f-44b9-a394-62d463e4ef72",
            name: "New Account Name",
            throttling: {
              interval: 1,
              amount: 100,
              current: 50,
            },
          })
        end
      end
    end

    describe '#get_account' do
      let(:response_json) { instance.get_account.deep_symbolize_keys }

      it 'returns the Account JSON' do
        VCR.use_cassette('get_account') do
          expect(response_json).to eql({
            id: "10a6e55e-a89f-44b9-a394-62d463e4ef72",
            name: "EShoes",
            throttling: {
              interval: 1,
              amount: 100,
              current: 95,
            },
          })
        end
      end
    end
  end
end
