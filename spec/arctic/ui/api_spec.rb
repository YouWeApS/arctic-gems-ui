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
              current: 98,
            },
          })
        end
      end
    end

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
              current: 73,
            },
          })
        end
      end
    end
  end

  describe 'shops endpoint' do
    describe '#get_shops' do
      let(:response_json) { instance.get_shops.deep_symbolize_keys }

      it 'returns all shops' do
        VCR.use_cassette('get_shops') do
          expect(response_json).to eql [
            {
              id: "8e25477b-8cb3-4707-a304-599097ee5aa2",
              name: "DK shop",
            },
          ]
        end
      end
    end
  end

  describe 'preprocessors endpoint' do
    describe '#get_preprocessors' do
      let(:response_json) { instance.get_preprocessors.deep_symbolize_keys }

      it 'returns all preprocessors' do
        VCR.use_cassette('get_preprocessors') do
          expect(response_json).to eql [
            {
              id: "ae7a8526-e79c-4d28-8350-e88918e02c72",
              name: "dandomain",
            },
          ]
        end
      end
    end
  end

  describe 'preprocessor configurations' do
    describe '#add_shop_preprocessor' do
      it 'is possible to add a preprocessor configuration to a shop' do
        VCR.use_cassette('add_shop_preprocessor') do
          response = instance.add_shop_preprocessor \
            shop_id: '8e25477b-8cb3-4707-a304-599097ee5aa2',
            preprocessor_id: 'ae7a8526-e79c-4d28-8350-e88918e02c72',
            config: { a: :b }
          expect(response.deep_symbolize_keys).to eql(
            id: '7e0aca5f-3262-4ebe-9055-6617a44f2682',
            name: 'dandomain',
            preprocessor_id: 'ae7a8526-e79c-4d28-8350-e88918e02c72',
            config: { a: 'b' })
        end
      end
    end

    describe '#update_shop_preprocessor' do
      it 'is possible to add a preprocessor configuration to a shop' do
        VCR.use_cassette('update_shop_preprocessor') do
          add_response = instance.add_shop_preprocessor \
            shop_id: '8e25477b-8cb3-4707-a304-599097ee5aa2',
            preprocessor_id: 'ae7a8526-e79c-4d28-8350-e88918e02c72',
            config: { a: :b }
          response = instance.update_shop_preprocessor \
            id: add_response['id'],
            shop_id: '8e25477b-8cb3-4707-a304-599097ee5aa2',
            config: { c: :d }
          expect(response.deep_symbolize_keys).to eql(
            id: '67e49991-2961-4c72-9821-e26889959ce2',
            name: 'dandomain',
            preprocessor_id: 'ae7a8526-e79c-4d28-8350-e88918e02c72',
            config: { c: 'd' })
        end
      end
    end

    describe '#get_shop_preprocessors' do
      it 'is possible to add a preprocessor configuration to a shop' do
        VCR.use_cassette('get_shop_preprocessors') do
          response = instance.get_shop_preprocessors \
            shop_id: '8e25477b-8cb3-4707-a304-599097ee5aa2'

          expect(response.deep_symbolize_keys).to eql [
            {
              id: "e542a79d-f82b-46d4-9d92-ea43c657b695",
              name: "dandomain",
              preprocessor_id: "b5f4d7e7-255e-480e-8b57-70713915b6cf",
              config: {
                user: "youwe",
                password: "Youweloveslife",
                prices_file_id: 126,
                products_file_id: 127,
              },
            },
          ]
        end
      end
    end
  end
end
