# 法大大实名认证接口调用顺序（一）
# 个人开户
customer_id = Fadada::Account.person_register('N12345678901')

# 企业开户
customer_id = Fadada::Account.company_register('N09876543211')
