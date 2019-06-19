# 法大大实名认证接口调用顺序（五）

contract_id = "19273648172364987165"
doc_title = "这是一个测试合同"
contract_file = File.open('xxx')

# 上传合同
options = {
  contract_id: contract_id, # 合同编号
  doc_title: doc_title,
  file: contract_file
}
Fadada::Contract.upload_doc(options)

# 上传合同模板
options = {
  template_id: '9769867876876876',
  file: contract_file
}
Fadada::Contract.upload_template(options)

# 模板填充
options = {

}
Fadada::Contract.generate(options)

# 自动签署合同
options = {
  transaction_id: 'A1028374019287342342',
  contract_id: contract_id,
  doc_title: doc_title,
}
Fadada::Contract.auto_sign(options)

# 手动签署合同
options = {
  transaction_id: 'B1028374019287341114',
  contract_id: contract_id,
  customer_id: '926064BA49FB4EAA0F1323A0B000DA22',
  doc_title: doc_title,
  sign_keyword: '甲方（盖章）：',
  keyword_strategy: '2',
  customer_name: 'xx',
  customer_ident_no: 'xx',
  return_url: 'http://baidu.com'
}
Fadada::Contract.sign(options)

# 查看合同
Fadada::Contract.show(contract_id)

# 下载合同
Fadada::Contract.download(contract_id)

# 合同归档
Fadada::Contract.filing(contract_id)
