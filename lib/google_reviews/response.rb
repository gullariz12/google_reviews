# frozen_string_literal: true

module GoogleReviews
  # Response Object
  class Response
    attr_reader :status, :data, :error

    def initialize(data: [], status: "OK", error: "")
      @data = data
      @status = status
      @error = error
    end

    def success?
      status == "OK"
    end
  end
end
