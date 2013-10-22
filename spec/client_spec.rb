require 'spec_helper'
require 'facebook_chat'

describe FacebookChat::Client do
  let(:api_key) { 'api_key' }
  let(:host)    { 'example.com' }

  before do
    FacebookChat::Client.configure do |config|
      config.api_key = api_key
      config.host = host
    end
  end

  describe 'configuration' do
    it 'should have correct configuration' do
      expect(FacebookChat::Client.configuration.api_key).to eq api_key
      expect(FacebookChat::Client.configuration.host).to eq host
    end
  end
end
