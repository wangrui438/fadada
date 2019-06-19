# 法大大实名认证相关接口
# 实名认证分为在调用方处做实名认证和在法大大处做实名认证
# 在调用方处做实名认证需要调用法大大的实名信息存证接口
# 实名存证方式有以下两种：
#   1. 实名信息哈希存证是将用户的信息放在一份文档里将这份文件进行sha256算法，将文件hash值传入到法大大这边进行存证。
#   2.（企业 or 个人）实名信息存证是将对应的信息以明文的方式通过参数传输到法大大这边进行存证。
# 建议使用方式2实名信息存证，资料尽量全一些，这是对调用方有利的。资料越齐全，以后举证越容易被采信
module Fadada
  class Authentication

    # 个人实名信息存证
    def self.person_deposit(params = {})
      _basic = %i(bank_essential_factor cert_flag customer_id document_type idcard live_detection mobile
      mobile_and_bank_essential_factor mobile_essential_factor name preservation_data_provider preservation_desc
      preservation_name public_security_essential_factor verified_time verified_type)
      _normal = %i(idcard_positive_file idcard_negative_file live_detection_file)
      options = params.slice(*(_basic + _normal))
      digest_params = { _params: params.slice(*_basic) }
      response = Fadada::HttpClient.request(:post, 'person_deposit.api', options, digest_params)
      response['data']
    end

    # 企业实名信息存证
    def self.company_deposit(params = {})
      _basic = %i(amount_or_random_code cert_flag company_name company_principal_type company_principal_verified_msg
      credit_code customer_bank customer_bank_account customer_branch_bank customer_id document_type legal_idcard
      legal_name licence organization pay_type preservation_data_provider preservation_desc preservation_name
      public_bank_account public_branch_bank transaction_id user_back_fill_amount_or_random_code verified_mode verified_time)
      _normal = %i(credit_code_file licence_file organization_file power_attorney_file idcard_positive_file idcard_negative_file
      live_detection_file)
      options = params.slice(*(_basic + _normal))
      digest_params = { _params: params.slice(*_basic) }
      response = Fadada::HttpClient.request(:post, 'company_deposit.api', options, digest_params)
      response['data']
    end

    # 获取企业实名认证地址
    def self.company_url

    end

    # 获取个人实名认证地址
    def self.person_url

    end
  end
end
