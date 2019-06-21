require "fadada/version"
require "fadada/configuration"
require "fadada/digest"
require "fadada/http_client"

# resources
require "fadada/account"
require "fadada/authentication"
require "fadada/certificate"
require "fadada/contract"
require "fadada/signature"

# exceptions
require "fadada/api_service_exception"

module Fadada
  class << self
    def setup
      yield config
    end

    def config
      @config ||= Configuration.new
    end
  end
end
