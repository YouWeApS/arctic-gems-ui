require "spec_helper"

RSpec.describe Arctic::Core do
  it 'can be configured' do
    Arctic::Core.configure do |config|
      config.token = 'Hello'
    end
    expect(Arctic::Core.configuration.token).to eql('Hello')
  end
end
