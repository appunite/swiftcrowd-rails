module Errors
  class ApiError < StandardError

    CODES = { 
      400 => [:invalid_request, :invalid_grant],
      401 => [:unauthorized_client, :invalid_token, :expired_token],
      403 => [:insufficient_scope],
      404 => [:not_found],
      422 => [:unprocessable_entity],
      500 => [:server_error] }

    attr_reader :error, :description
    def initialize(error, description = nil)
      @error = error
      @description = description
    end

    def message
      @message || super
    end

    def as_json
      json = { error: @error }
      json[:title] = I18n.t("controller.common.error")
      json[:description] = description if description
      json
    end

    def response_status
      self.class.status_from(error)
    end

    class << self
      def status_from(error)
        (code = CODES.find { |k,v| v.include?(error) }) ? code.first : 400
      end
    end

  end
end