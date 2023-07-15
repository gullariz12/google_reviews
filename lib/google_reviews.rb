# frozen_string_literal: true

require "uri"
require "json"
require "net/http"
require "google_reviews/error"
require "google_reviews/utils"
require "google_reviews/response"
require "google_reviews/constants"
require "google_reviews/api_request"
require "google_reviews/translations"
require_relative "google_reviews/version"

module GoogleReviews
  # Service to fetch reviews based on place_name or place_id
  class Reviews
    def self.fetch_reviews_by_place_name(api_key, place_name)
      url = Utils.request_uri(api_key, place_name: place_name)

      begin
        data = Utils.execute_place_name_request(url)
        return GoogleReviews::Response.new unless data

        fetch_reviews_by_place_id(api_key, data.first["place_id"])
      rescue ApiError => e
        GoogleReviews::Response.new(status: "409", error: e)
      end
    end

    def self.fetch_reviews_by_place_id(api_key, place_id)
      url = Utils.request_uri(api_key, place_id: place_id)

      begin
        Utils.execute_place_id_request(url)
      rescue ApiError => e
        GoogleReviews::Response.new(status: "409", error: e)
      end
    end
  end
end
