# frozen_string_literal: true

module GoogleReviews
  class Error < StandardError; end

  class ApiError < Error; end
  class InvalidApiKeyError < ApiError; end
  class InvalidPlaceIdError < ApiError; end
end
