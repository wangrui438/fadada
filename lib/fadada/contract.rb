# 法大大合同相关接口
module Fadada
  class Contract
    # 上传合同
    # 接入平台生成 PDF 文档后通过此接口将文档传输到法大大，供签署时使用。
    # 非 PDF 文档请使用合同模板功能(参考合同模板传输接口和合同生成接口)
    # 该接口只支持PDF文件
    def self.upload_doc(params = {})
      options = params.slice(:contract_id, :doc_title, :doc_url, :file).merge(doc_type: '.pdf')
      digest_params = { _params: params.slice(:contract_id) }
      response = Fadada::HttpClient.request(:post, 'uploaddocs.api', options, digest_params)
    end

    # 上传合同模板
    # 此接口与模板填充接口配合使用，接入方预先将制作好的 PDF 模板通过此接口上传到法大大，
    # 后续如需要签署合同时只需要将需填充的内容通过合同生成接口传入，即可生成合同供签署操作，提高效率，
    # 并可防止接入方自己生成的合同出现一些不兼容或文档签署异常等情况。
    def self.upload_template(params = {})
      options = params.slice(:template_id, :doc_url, :file)
      digest_params = { _params: params.slice(:template_id) }
      response = Fadada::HttpClient.request(:post, 'uploadtemplate.api', options, digest_params)
    end

    # 模板填充
    # 将需填充的内容通过模板填充接口传入，即可生成合同供签署操作，提高效率，
    # 并可防止接入方自己生成的合同出现一些不兼容或文档签署异常等情况。
    def self.generate(params = {})
      _basic = %i(template_id contract_id)
      _extend = %i(parameter_map)
      _normal = %i(doc_title font_size font_type dynamic_tables)
      options = params.slice(*(_basic + _extend + _normal))
      digest_params = { _params: params.slice(*_basic), _extend_params: params.slice(*_extend) }
      response = Fadada::HttpClient.request(:post, 'generate_contract.api', options, digest_params)
    end

    # 自动签署合同
    # 自动签接口不需要用户亲自操作，当接入平台调用此接口时，就会在指定的电子合同上签上指定用户的电子章，
    # 省略了用户交互的步骤。因此如果需要使用此接口的能力， 需要接入平台联系法大大商务签署补充协议。
    #
    # 默认情况下只需要传入如下参数
    # {
    #   transaction_id: '',
    #   contract_id: '',
    #   doc_title: ''
    # }
    #
    def self.auto_sign(params = {})
      _options = {
        customer_id: Fadada::config.customer_id, # 接入平台客户编号
        client_role: '1', # 客户角色 1-接入平台
        position_type: '0', # 定位类型 0-关键字(默认)
        sign_keyword: Fadada::config.customer_name, # 定位关键字，默认按照接入平台方的名称定位
        keyword_strategy: '2', # 关键字签章策略 2:最后一个关键字签章;
      }
      _basic = %i(customer_id)
      _md5 = %i(transaction_id)
      _normal = %i(contract_id client_role doc_title position_type sign_keyword keyword_strategy signature_positions notify_url)
      options = _options.merge(params.slice(*(_basic + _md5 + _normal)))
      digest_params = { _params: options.slice(*_basic), _md5_params: options.slice(*_md5) }
      response = Fadada::HttpClient.request(:post, 'extsign_auto.api', options, digest_params)
    end

    # 手动签署合同
    # 该接口为页面接口，接入方平台可以在合适的业务场景嵌入该接口链接，引导客户至法大大进行文档签署
    # (比如可以在接入方平台网站上放置一个按钮，该按钮触发跳转至法大大或将法大大签章页面嵌入接入方流程)。
    # 法大大根据浏览器 UA 信息，自动加载签 章界面对应的 PC web 版本或移动 HTML5 版本。
    # 用户在法大大的签署页面中进行签署操作。
    def self.sign(params = {})
      _basic = %i(customer_id)
      _md5 = %i(transaction_id)
      _normal = %i(contract_id doc_title sign_keyword keyword_strategy return_url notify_url customer_mobile customer_name customer_ident_no)
      options = params.slice(*(_basic + _md5 + _normal))
      digest_params = { _params: params.slice(*_basic), _md5_params: params.slice(*_md5) }
      response = Fadada::HttpClient.request(:get, 'extsign.api', options, digest_params)
    end

    # 合同查看
    # 页面接口，返回签署页面，根据浏览器 UA 信息返回 pc 或 H5 页面.
    def self.show(contract_id)
      options = { contract_id: contract_id }
      response = Fadada::HttpClient.request(:get, 'viewContract.api', options)
    end

    # 合同下载
    # 通过合同编号下载文档(PDF 格式)，可通过 Content-Length 取文件大小。
    # 正常时直接返回 PDF 文档(MIME:application/pdf)，异常时返回 JSON 报文
    def self.download(contract_id)
      options = { contract_id: contract_id }
      response = Fadada::HttpClient.request(:get, 'downLoadContract.api', options)
    end

    # 合同归档
    # 接入平台更新合同签署状态为-签署完成，法大大将把合同所有相关操作记录进行归档存证。
    # 归档后将不能再对文档再进行签署操作。
    def self.filing(contract_id)
      options = { contract_id: contract_id }
      response = Fadada::HttpClient.request(:post, 'contractFiling.api', options)
    end
  end
end
