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

response = GoogleReviews::Reviews.fetch_reviews_by_place_id(api_key, place_id)
reviews = response.data

reviews.each do |review|
  puts "Author: #{review.author_name}"
  puts "Rating: #{review.rating}"
  puts "Review Text: #{review.text}"
  puts "---"
end
```

Make sure to replace `YOUR_API_KEY` with your actual Google Places API key.

## Error Handling

The gem provides custom method `response.success?` to check if the action was successful. If the action was successful, `response.data` will contain an array of `GoogleReview::Review` objects. In the case of an error, `response.error` will provide a descriptive error message explaining what went wrong.

## Configuration
The gem doesn't require any additional configuration. However, it's recommended to configure the locale for translations. By default, the gem uses English (`:en`) as the locale. If you want to use a different locale, you can modify the `lib/google_reviews/translations.rb file`.

## Submitting a Pull Request

1. [Fork](https://help.github.com/articles/fork-a-repo/) the [official repository](https://github.com/gullariz12/google_reviews).
1. [Create a topic branch.](https://help.github.com/articles/creating-and-deleting-branches-within-your-repository/)
1. Implement your feature or bug fix.
1. Add, commit, and push your changes.
1. [Submit a pull request.](https://help.github.com/articles/using-pull-requests/)

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
