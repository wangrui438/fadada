# 法大大实名认证接口调用顺序（五）

contract_id = DateTime.now.to_i
doc_title = "这是一个测试合同"
contract_file = File.open('xxx')

# 上传合同
options = {
  contract_id: contract_id, # 合同编号
  doc_title: doc_title,
  file: contract_file
}
Fadada::Contract.upload_doc(options)

template_id = DateTime.now.to_i

# 上传合同模板
options = {
  template_id: template_id,
  file: contract_file
}
Fadada::Contract.upload_template(options)

json_obj = {}
(1..29).each do |item|
  json_obj[item.to_s] = "this is #{item} test"
end
# 模板填充
options = {
  doc_title: "据说这是一个测试合同",
  template_id: template_id,
  contract_id: contract_id,
  parameter_map: json_obj.to_json
}
Fadada::Contract.generate(options)

# 自动签署合同
options = {
  transaction_id: DateTime.now.to_i,
  contract_id: contract_id,
  doc_title: doc_title,
  sign_keyword: '杨米尔斯'
}
Fadada::Contract.auto_sign(options)

# 手动签署合同
options = {
  transaction_id: DateTime.now.to_i,
  contract_id: contract_id,
  customer_id: '926064BA49FB4EAA0F1323A0B000DA22',
  doc_title: doc_title,
  sign_keyword: '杨米尔斯',
  keyword_strategy: '2',
  customer_name: '张三',
  customer_ident_no: 'xxx',
  return_url: 'http://baidu.com'
}
Fadada::Contract.sign(options)

# 批量手动签署合同
sign_data = [{
    contractId: '123',
    signKeyword: '甲方',
    transactionId: DateTime.now.to_i,
    keywordStrategy: '2'
  },{
    contractId: '456',
    signKeyword: '甲方',
    transactionId: DateTime.now.to_i,
    keywordStrategy: '2'
  }].to_json

options = {
  customer_id: '926064BA49FB4EAA0F1323A0B000DA22',
  # outh_customer_id: '',
  batch_id: DateTime.now.to_i,
  batch_title: '批量合同签署',
  mobile_sign_type: '1',
  return_url: 'http://baidu.com',
  # notify_url: '',
  customer_mobile: 'xxx',
  sign_data: URI.encode(sign_data)
}
Fadada::Contract.batch_sign(options)

# 查看合同
Fadada::Contract.show(contract_id)

# 下载合同
Fadada::Contract.download(contract_id)

# 合同归档
Fadada::Contract.filing(contract_id)
