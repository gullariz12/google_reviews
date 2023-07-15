# frozen_string_literal: true

require "google_reviews/constants"

RSpec.describe GoogleReviews::Utils do
  describe ".request_uri" do
    let(:api_key) { "AAA-TEST-API-KEY" }

    context "when place_id is provided" do
      let(:place_id) { "AAA-TEST-PLACE-ID" }
      let(:expected_uri) { "#{PLACE_ID_SEARCH_BASE_URI}?place_id=#{place_id}&fields=reviews&key=#{api_key}" }

      it "returns the correct URI" do
        uri = GoogleReviews::Utils.request_uri(api_key, place_id: place_id)
        expect(uri).to eq(expected_uri)
      end
    end

    context "when place_name is provided" do
      let(:place_name) { "test place name" }
      let(:encoded_place_name) { "test encoded place name" }
      let(:expected_uri) { "#{PLACE_TEXT_SEARCH_BASE_URI}?query=#{encoded_place_name}&key=#{api_key}" }

      before do
        allow(GoogleReviews::Utils).to receive(:encoded_place_name).with(place_name).and_return(encoded_place_name)
      end

      it "returns the correct URI" do
        uri = GoogleReviews::Utils.request_uri(api_key, place_name: place_name)
        expect(uri).to eq(expected_uri)
      end
    end

    context "when neither place_id nor place_name is provided" do
      it "returns nil" do
        uri = GoogleReviews::Utils.request_uri(api_key)
        expect(uri).to be_nil
      end
    end
  end

  describe ".formatted_reviews_data" do
    let(:reviews) do
      [
        { "author_name" => "Author 1", "rating" => 4, "text" => "Review 1" },
        { "author_name" => "Author 2", "rating" => 5, "text" => "Review 2" }
      ]
    end

    let(:expected_formatted_reviews) do
      [
        GoogleReviews::Review.new({ author_name: "Author 1", rating: 4, text: "Review 1" }),
        GoogleReviews::Review.new({ author_name: "Author 2", rating: 5, text: "Review 2" })
      ]
    end

    it "returns the formatted reviews data" do
      formatted_reviews = GoogleReviews::Utils.formatted_reviews_data(reviews)
      expect(formatted_reviews.size).to eq(expected_formatted_reviews.size)
    end
  end

  describe ".encoded_place_name" do
    let(:place_name) { "Example Place Name" }
    let(:expected_encoded_name) { "Example+Place+Name" }

    it "returns the encoded place name" do
      encoded_name = GoogleReviews::Utils.encoded_place_name(place_name)
      expect(encoded_name).to eq(expected_encoded_name)
    end
  end
end
