# frozen_string_literal: true

require "google_reviews/review"

# GoogleReviews module
module GoogleReviews
  # Various utility methods
  module Utils
    def request_uri(api_key, place_id: nil, place_name: nil)
      if place_id
        "#{PLACE_ID_SEARCH_BASE_URI}?place_id=#{place_id}&fields=reviews&key=#{api_key}"
      elsif place_name
        "#{PLACE_TEXT_SEARCH_BASE_URI}?query=#{encoded_place_name(place_name)}&key=#{api_key}"
      end
    end

    def formatted_reviews_data(reviews)
      return [] if reviews.nil? || reviews.empty?

      reviews.map do |review|
        Review.new(review)
      end
    end

    def execute_place_name_request(url)
      data = ApiRequest.execute(url)

      raise ApiError, I18n.t("messages.search_place_api_error", exception: data["status"]) unless data["status"] == "OK"

      data["results"]
    end

    def execute_place_id_request(url)
      data = ApiRequest.execute(url)

      error = I18n.t("messages.search_id_api_error", exception: data["status"])
      return GoogleReviews::Response.new(status: data["status"], error: error) unless data["status"] == "OK"

      reviews = data["result"]["reviews"]
      return GoogleReviews::Response.new if reviews.nil? || reviews.empty?

      GoogleReviews::Response.new(data: formatted_reviews_data(reviews))
    end

    private

    def encoded_place_name(place_name)
      URI.encode_www_form_component(place_name)
    end

    module_function :request_uri, :formatted_reviews_data, :encoded_place_name, :execute_place_id_request,
                    :execute_place_name_request
  end
end
