# 法大大证书相关接口
module Fadada
  class Certificate

    # 编号证书申请
    # 调用此接口可以给相关账号颁发编号证书
    #
    #   customer_id => 客户编号 注册账号时返回
    #   evidence_no => 存证编号 实名信息存证时返回
    #
    def self.apply(customer_id:, evidence_no:)
      options = {
        customer_id: customer_id,
        evidence_no: evidence_no
      }
      response = Fadada::HttpClient.request(:post, 'apply_client_numcert.api', options)
    end
  end
end
