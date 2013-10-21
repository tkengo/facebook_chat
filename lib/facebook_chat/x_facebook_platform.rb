require 'cgi'

module FacebookChat
  class XFacebookPlatform < Jabber::SASL::Base
    def initialize(stream)
      super

      challenge = {}
      error = nil
      stream.send(generate_auth('X-FACEBOOK-PLATFORM')) do |reply|
        if reply.name == 'challenge' and reply.namespace == Jabber::SASL::NS_SASL
          challenge = CGI.parse(Base64::decode64(reply.text))
        else
          error = reply.first_element(nil).name
        end
        true
      end
      raise error if error

      @method = challenge['method'][0]
      @nonce = challenge['nonce'][0]
    end

    def auth(access_token)
      response = {
        :method => @method,
        :nonce => @nonce,
        :access_token => access_token,
        :api_key => FacebookChat::Client.configuration.api_key,
        :call_id => Time.now.to_i,
        :v => '1.0'
      }
      response_text = response.collect {|k, v| "#{k}=#{v}" }.join('&')

      response = REXML::Element.new('response')
      response.add_namespace Jabber::SASL::NS_SASL
      response.text = Base64::encode64(response_text)

      error = nil
      @stream.send(response) do |reply|
        if reply.name != 'success'
          error = reply.first_element(nil).name
        end
        true
      end

      raise error if error
    end
  end
end
