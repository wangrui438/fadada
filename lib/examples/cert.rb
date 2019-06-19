# 法大大实名认证接口调用顺序（三）
# 编号证书申请
customer_id = 'xxx' # 客户编号
evidence_no = 'xxx' # 存证编号
cert = Fadada::Certificate.apply(customer_id: customer_id, evidence_no: evidence_no)
