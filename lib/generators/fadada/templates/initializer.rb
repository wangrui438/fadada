logger = Logger.new(STDOUT)
Fadada.setup do |config|
  config.server = "https://testapi.fadada.com:8443"
  config.app_id = ""
  config.app_secret = ""
  config.customer_id = "" # 平台方客户编号
  config.customer_name = "" # 平台方客户名称
  config.logger = logger
  config.logger_format = :curl
end
