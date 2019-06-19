# 法大大签章相关接口
module Fadada
  class Signature
    # 签章上传
    # 新增用户签章图片
    #
    #   customer_id => 客户编号
    #   image => 签章图片地址或者base64图片数据
    #   type => image 类型，base64 或者 path
    #
    #   返回签章图片ID
    #
    def self.upload(customer_id:, type: 'base64', image:)
      options = {
        customer_id: customer_id,
        signature_img_base64: type == 'base64' ? image : image_to_base64(image)
      }
      response = Fadada::HttpClient.request(:post, 'add_signature.api', options)
      response['data']
    end

    # 自定义印章
    # 获取用户自定义签章图片
    #
    #   customer_id => 客户编号
    #   content => 印章展示的内容，可以是企业名称或者客户名称
    def self.custom(customer_id:, content:)
      options = {
        customer_id: customer_id,
        content: content
      }
      response = Fadada::HttpClient.request(:post, 'custom_signature.api', options)
      response['data']['signature_img_base64']
    end

    private

    def self.image_to_base64(path)
      File.open(path, 'rb') do |img|
        Base64.strict_encode64(img.read)
      end
    end
  end
end
