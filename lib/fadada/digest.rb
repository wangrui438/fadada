# 法大大摘要相关
module Fadada
  class Digest
    # 生成摘要
    # Base64(SHA1(app_id + MD5(timestamp + 参数集合1) + SHA1(app_secret + 参数集合) + 参数集合2 ))
    # 示例：
    # options = {
    #   _params: { a: 1, b: 2 },
    #   _md5_params: { a: 1, b: 2 },
    #   _extend_params: { a: 1, b: 2 }
    # }
    #
    def self.generate(timestamp, options = {})
      _biz_data = Fadada::config.app_secret + params_transform(options[:_params])
      _sha1_biz_data = ::Digest::SHA1.hexdigest(_biz_data).upcase
      _md5 = ::Digest::MD5.hexdigest(params_transform(options[:_md5_params]) + timestamp).upcase
      _extend = params_transform(options[:_extend_params])
      _data = ::Digest::SHA1.hexdigest(::Fadada::config.app_id + _md5 + _sha1_biz_data + _extend).upcase
      Base64.strict_encode64(_data)
    end


    # 验证摘要
    def self.verify?(params = {})
      options = params.transform_keys(&:to_sym)
      _timestamp = options[:timestamp]
      digest_params = { _params: { transaction_id: options[:transaction_id] } }
      options[:msg_digest].to_s == generate(_timestamp, digest_params)
    end

    private

    # 处理参数
    # 需要排序后使用
    def self.params_transform(options)
      _options = options || {}
      _options.delete_if { |key, value| value.blank? }.sort.map { |k,v| v }.join
    end
  end
end
