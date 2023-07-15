# frozen_string_literal: true

module GoogleReviews
  # Google Review Object
  class Review
    attr_accessor :text, :time, :rating, :language, :author_url, :translated, :author_name,
                  :original_language, :profile_photo_url, :relative_time_description

    def initialize(data)
      @text = data["text"]
      @time = data["time"]
      @rating = data["rating"]
      @language = data["language"]
      @author_url = data["author_url"]
      @translated = data["translated"]
      @author_name = data["author_name"]
      @original_language = data["original_language"]
      @profile_photo_url = data["profile_photo_url"]
      @relative_time_description = data["relative_time_description"]
    end
  end
end
