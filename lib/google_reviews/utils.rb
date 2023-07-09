# frozen_string_literal: true

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
      reviews.map do |review|
        {
          author_name: review["author_name"],
          rating: review["rating"],
          text: review["text"]
        }
      end
    end

    private

    def encoded_place_name(place_name)
      URI.encode_www_form_component(place_name)
    end

    module_function :request_uri, :formatted_reviews_data, :encoded_place_name
  end
end
