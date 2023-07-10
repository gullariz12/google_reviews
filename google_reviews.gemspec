# frozen_string_literal: true

require_relative "lib/google_reviews/version"

Gem::Specification.new do |spec|
  spec.name = "google_reviews"
  spec.version = GoogleReviews::VERSION
  spec.authors = ["gullariz12"]
  spec.email = ["gullariz82@gmail.com"]

  spec.summary = "A gem for retrieving reviews for a specific location from the Google Places API"
  spec.description = <<-DESC
  Google Reviews Gem is a Ruby gem that provides an easy-to-use interface for fetching reviews for a specific location from the Google Places API. It allows you to retrieve reviews written by users for a given place and provides useful information such as the author's name, rating, and review text.
  DESC
  spec.homepage = "https://github.com/gullariz12/google_reviews"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/gullariz12/google_reviews"
  spec.metadata["changelog_uri"] = "https://github.com/gullariz12/google_reviews/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "i18n"
  spec.add_development_dependency("webmock", "~> 2.0")
end
