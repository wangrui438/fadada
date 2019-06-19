# 法大大实名认证接口调用顺序（四）
# 上传签章
customer_id = '' # 客户编号
path = 'xx' # 签章图片 base64
sign = Fadada::Signature.upload(customer_id: customer_id, image: path, type: 'path')

# 自定义签章
customer_id = '' # 客户编号
content = '测试测试' # 印章展示的内容，可以是企业名称或者客户名称
sign = Fadada::Signature.custom(customer_id: customer_id, content: content)
