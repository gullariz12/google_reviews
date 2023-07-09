# frozen_string_literal: true

# GoogleReviews module
module GoogleReviews
  # Make API request to fetch google reviews
  module ApiRequest
    def execute(url)
      http_request = build_request(url)
      request_client = build_http_client(url)

      response = request_client.request(http_request)

      raise ApiError, error_message unless response.is_a?(Net::HTTPSuccess)

      parsed_response(response)
    rescue StandardError => e
      raise ApiError, I18n.t("messages.api_request_error", exception: e)
    end

    private

    def build_http_client(url)
      uri = URI(url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true

      https
    end

    def build_request(url)
      uri = URI(url)

      Net::HTTP::Get.new(uri.request_uri)
    end

    def parsed_response(response)
      JSON.parse(response.body)
    rescue JSON::ParserError
      raise ApiError, I18n.t("messages.parser_error")
    end

    def error_message(response)
      I18n.t("messages.failed_request", code: response.code, message: response.message)
    end

    module_function :execute, :build_request, :build_http_client, :parsed_response, :error_message
  end
end
