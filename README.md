# Google Reviews Gem

The Google Reviews gem is a Ruby library that provides a service to fetch reviews from Google based on a place name or place ID. It utilizes the Google Places API to retrieve the reviews and provides a convenient interface for accessing the review data.

## Installation

Add this line to your Gemfile:

```
gem 'google_reviews'
```

And then execute:

```
$ bundle install
```

Or install it directly:

```
$ gem install google_reviews
```
## Usage
To fetch reviews based on a place name or place ID, you can use the `GoogleReviews::Reviews` class provided by the gem. Here's an example of how to use it:

```
require 'google_reviews'

api_key = 'YOUR_API_KEY'
place_id = 'PLACE_ID'

reviews = GoogleReviews::Reviews.fetch_reviews_by_place_id(api_key, place_id)

reviews.each do |review|
  puts "Author: #{review[:author_name]}"
  puts "Rating: #{review[:rating]}"
  puts "Review Text: #{review[:text]}"
  puts "---"
end
```

Make sure to replace `YOUR_API_KEY` with your actual Google Places API key.

## Error Handling

The gem provides custom error classes that you can handle to deal with specific error scenarios. Here are the error classes available:

- `GoogleReviews::ApiError:` Represents general API-related errors.
- `GoogleReviews::InvalidApiKeyError:` Indicates an invalid API key error.
- `GoogleReviews::InvalidPlaceIdError:` Indicates an invalid place ID error.
You can rescue and handle these errors to provide appropriate error handling in your application.

## Configuration
The gem doesn't require any additional configuration. However, it's recommended to configure the locale for translations. By default, the gem uses English (`:en`) as the locale. If you want to use a different locale, you can modify the `lib/google_reviews/translations.rb file`.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gullariz12/google_reviews. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/gullariz12/google_reviews/blob/master/CODE_OF_CONDUCT.md).
