# 法大大接口层面异常类
module Fadada
  class ApiServiceException < StandardError
    attr_reader :code, :message

    def initialize(code, message)
      @code = code
      @message = message
      super(message)
    end
  end
end
