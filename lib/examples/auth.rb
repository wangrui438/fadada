# 法大大实名认证接口调用顺序（二）

file = File.open('xxx')

# 个人实名信息存证
options = {
  customer_id: customer_id,
  preservation_name: '个人实名信息存证', # 存证名称
  preservation_data_provider: 'XX网络科技有限公司', # 存证提供方
  name: '张三',
  idcard: 'xxx', # 证件号
  idcard_positive_file: '', # 证件照正面
  idcard_negative_file: '', # 证件照反面
  verified_time: DateTime.now.strftime('%Y-%m-%d %H:%M:%S'),
  verified_type: 'Z', # 实名认证类型，Z 其他
  cert_flag: '0'
}
evidence_no = Fadada::Authentication.person_deposit(options)

# 企业实名信息存证
options = {
  customer_id: customer_id,
  preservation_name: '企业实名信息存证',
  preservation_data_provider: 'XX网络科技有限公司',
  company_name: 'XX公司',
  document_type: '1', # 证件类型 1:三证合一 2:旧版营业执照
  credit_code: '91827364817263', # 统一社会信用代码
  credit_code_file: file, # 统一社会信用代码电子版
  verified_time: DateTime.now.strftime('%Y-%m-%d %H:%M:%S'), # 实名时间
  verified_mode: '1', # 实名认证方式 1:授权委托书 2:银行对公打款
  power_attorney_file: file, # 授权委托书电子版
  company_principal_type: '1', # 企业负责人身份:1. 法人，2 代理人
  company_principal_verified_msg: { # 企业负责人实名存证信息
    customer_id: '671C6CC93D9F4C0630911735795666A2',
    preservation_name: '个人实名信息存证',
    preservation_data_provider: 'XX网络科技有限公司', # 存证提供方
    name: '张三',
    idcard: 'xxx', # 证件号
    verified_time: DateTime.now.strftime('%Y-%m-%d %H:%M:%S'),
    verified_type: 'Z' # 实名认证类型，Z 其他
  }.to_json,
  transaction_id: '127635172637217', # 交易号
  cert_flag: '0'
}
evidence_no = Fadada::Authentication.company_deposit(options)
