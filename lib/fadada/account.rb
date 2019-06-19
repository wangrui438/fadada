# 法大大账户相关接口
module Fadada
  class Account

    # 注册账号
    #
    #   此接口针对接入平台已有账号体系，判断 open_id 是否存在
    #   存在则返回对应账号，否则随机生成账号并返回账号
    #
    #   open_id => 用户在接入方的唯一标识，length <= 64
    #
    #   返回 法大大的账号
    def self.person_register(open_id)
      options = {
        open_id: open_id,
        account_type: 1 # 账户类型，1 个人；2 企业，默认 1
      }
      response = Fadada::HttpClient.request(:post, 'account_register.api', options)
      response['data']
    end

    # 注册账号
    #
    #   此接口针对接入平台已有账号体系，判断 open_id 是否存在
    #   存在则返回对应账号，否则随机生成账号并返回账号
    #
    #   open_id => 用户在接入方的唯一标识，length <= 64
    #
    #   返回 法大大的账号
    def self.company_register(open_id)
      options = {
        open_id: open_id,
        account_type: 2 # 账户类型，1 个人；2 企业，默认 1
      }
      response = Fadada::HttpClient.request(:post, 'account_register.api', options)
      response['data']
    end
  end
end
