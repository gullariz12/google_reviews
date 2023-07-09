# frozen_string_literal: true

require "uri"
require "json"
require "net/http"
require "google_reviews/error"
require "google_reviews/utils"
require "google_reviews/constants"
require "google_reviews/api_request"
require "google_reviews/translations"
require_relative "google_reviews/version"

module GoogleReviews
  # Service to fetch reviews based on place_name or place_id
  class Reviews
    def self.fetch_reviews_by_place_name(api_key, place_name)
      url = Utils.request_uri(api_key, place_name: place_name)

      data = ApiRequest.execute(url)

      raise ApiError, I18n.t("messages.search_place_api_error", exception: data["status"]) unless data["status"] == "OK"

      place_id = data["results"].first["place_id"]
      fetch_reviews_by_place_id(api_key, place_id)
    end

    def self.fetch_reviews_by_place_id(api_key, place_id)
      url = Utils.request_uri(api_key, place_id: place_id)

      data = ApiRequest.execute(url)

      raise ApiError, I18n.t("messages.search_id_api_error", exception: data["status"]) unless data["status"] == "OK"

      reviews = data["result"]["reviews"]
      return [] if reviews.nil? || reviews.empty?

      Utils.formatted_reviews_data(reviews)
    end
  end
end
