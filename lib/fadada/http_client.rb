module Fadada
  class HttpClient
    class << self
      # HTTP 请求
      # digest_params 示例：
      # {
      #   _params: { a: 1, b: 2 },
      #   _md5_params: { a: 1, b: 2 },
      #   _extend_params: { a: 1, b: 2 }
      # }
      #
      def request(method, action, params = {}, digest_params = nil)
        _method = method.to_s.downcase
        _digest_params = digest_params || { _params: params }
        payload = build_basic_params(_digest_params).merge(params)
        if _method == 'post'
          response = HTTParty.post(
            url(action),
            body: payload,
            header: form_header,
            logger: Fadada::config.logger,
            log_format: Fadada::config.logger_format
          ).parsed_response
          hander_exception(response)
        else
          "#{url(action)}?#{URI.encode_www_form(payload)}"
        end
      end

      private

      def url(action)
        Fadada::config.server + action
      end

      def form_header
        { 'Content-Type' => 'application/x-www-form-urlencoded;charset=utf8' }
      end

      # 构建基础请求参数
      def build_basic_params(options)
        _timestamp = DateTime.now.strftime("%Y%m%d%H%M%S")
        {
          app_id: Fadada::config.app_id,
          timestamp: _timestamp,
          v: '2.0',
          msg_digest: Fadada::Digest.generate(_timestamp, options)
        }
      end

      # 处理异常
      def hander_exception(response)
        code = response['code'].to_s
        return response if code == '1' || code == '1000'
        message = response['msg']
        if %w(0 1004).include?(code)
          message = response['data'] || response['msg']
        elsif code == '2'
          message = '重复请求'
        end
        raise Fadada::ApiServiceException.new(code, message)
      end
    end
  end
end
