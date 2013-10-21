require 'xmpp4r'

module FacebookChat
  class Client
    def initialize(access_token)
      @client = Jabber::Client.new(Jabber::JID.new)
      @client.connect(FacebookChat::Client.configuration.host)
      @client.auth_sasl(XFacebookPlatform.new(@client), access_token)
    end

    def send(id, message)
      jid = "#{id}@#{FacebookChat::Client.configuration.host}"
      message = Jabber::Message.new(jid, message)
      @client.send(message)
    end

    class << self
      attr_accessor :configuration
    end

    def self.configure
      self.configuration ||= Configuration.new
      yield(self.configuration)
    end

    class Configuration
      attr_accessor :api_key, :host

      def initialize
        @api_key = ''
        @host = 'chat.facebook.com'
      end
    end
  end
end
