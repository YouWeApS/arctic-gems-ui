require "spec_helper"

RSpec.describe Arctic::UI do
  it 'can be configured' do
    Arctic::UI.configure do |config|
      config.client_id = 'CLIENT_ID'
      config.client_secret = 'CLIENT_SECRET'
      config.url = 'https://google.com'
      config.scope = 'ui account:read'
    end
    expect(Arctic::UI.configuration.client_id).to eql('CLIENT_ID')
    expect(Arctic::UI.configuration.client_secret).to eql('CLIENT_SECRET')
    expect(Arctic::UI.configuration.url).to eql('https://google.com')
    expect(Arctic::UI.configuration.scope).to eql('ui account:read')
  end
end
