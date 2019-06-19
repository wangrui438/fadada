module Fadada
  class Configuration
    # 接口地址
    def server
      @server ||= 'https://testapi.fadada.com:8443/api/'
    end

    def server=(server)
      @server = server
    end

    # app_id
    def app_id
      @app_id
    end

    def app_id=(app_id)
      @app_id = app_id
    end

    # app_secret
    def app_secret
      @app_secret
    end

    def app_secret=(app_secret)
      @app_secret = app_secret
    end

    # 平台方客户编号
    def customer_id
      @customer_id
    end

    def customer_id=(customer_id)
      @customer_id = customer_id
    end

    # 平台方客户名称
    def customer_name
      @customer_name
    end

    def customer_name=(customer_name)
      @customer_name = customer_name
    end

    # logger
    def logger
      @logger ||= Logger.new(STDOUT)
    end

    def logger=(logger)
      @logger = logger
    end

    # logger format
    def logger_format
      @logger_format ||= :curl
    end

    def logger_format=(logger_format)
      @logger_format = logger_format.to_sym
    end
  end
end
