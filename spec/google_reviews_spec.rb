# frozen_string_literal: true

RSpec.describe GoogleReviews::Reviews do
  let(:url) { "example.url" }
  let(:place_id) { "TEST-PLACE-ID" }
  let(:api_key) { "AAA-TEST-API_KEY" }
  let(:place_name) { "TEST-PLACE-NAME" }

  describe ".fetch_reviews_by_place_name" do
    let(:data) { { "status" => "OK", "results" => [{ "place_id" => place_id }] } }

    before do
      allow(GoogleReviews::Utils).to receive(:request_uri).with(api_key, place_name: place_name).and_return(url)
      allow(GoogleReviews::ApiRequest).to receive(:execute).with(url).and_return(data)
    end

    context "when the search place API returns a successful response" do
      let(:reviews) { [{ text: "Review 1" }, { text: "Review 2" }] }
      let(:formatted_reviews) { ["Review 1", "Review 2"] }

      before do
        allow(GoogleReviews::Reviews).to receive(:fetch_reviews_by_place_id).with(api_key, place_id).and_return(reviews)
      end

      it "calls the Utils.request_uri method with the correct arguments" do
        expect(GoogleReviews::Utils).to receive(:request_uri).with(api_key, place_name: place_name)
        GoogleReviews::Reviews.fetch_reviews_by_place_name(api_key, place_name)
      end

      it "calls the ApiRequest.execute method with the correct URL" do
        expect(GoogleReviews::ApiRequest).to receive(:execute).with(url).and_return(data)
        GoogleReviews::Reviews.fetch_reviews_by_place_name(api_key, place_name)
      end

      it "calls fetch_reviews_by_place_id method with the correct arguments" do
        expect(GoogleReviews::Reviews).to receive(:fetch_reviews_by_place_id).with(api_key,
                                                                                   place_id).and_return(reviews)
        GoogleReviews::Reviews.fetch_reviews_by_place_name(api_key, place_name)
      end

      it "returns the formatted reviews data" do
        expect(GoogleReviews::Reviews.fetch_reviews_by_place_name(api_key, place_name)).to eq(reviews)
      end
    end
  end

  describe ".fetch_reviews_by_place_id" do
    let(:data) { { "status" => "OK", "result" => { "reviews" => reviews } } }

    before do
      allow(GoogleReviews::Utils).to receive(:request_uri).with(api_key, place_id: place_id).and_return(url)
      allow(GoogleReviews::ApiRequest).to receive(:execute).with(url).and_return(data)
    end

    context "when the search ID API returns a successful response with reviews" do
      let(:reviews) { [{ text: "Review 1" }, { text: "Review 2" }] }
      let(:formatted_reviews) { ["Review 1", "Review 2"] }

      it "calls the Utils.request_uri method with the correct arguments" do
        expect(GoogleReviews::Utils).to receive(:request_uri).with(api_key, place_id: place_id)
        GoogleReviews::Reviews.fetch_reviews_by_place_id(api_key, place_id)
      end

      it "calls the ApiRequest.execute method with the correct URL" do
        expect(GoogleReviews::ApiRequest).to receive(:execute).with(url).and_return(data)
        GoogleReviews::Reviews.fetch_reviews_by_place_id(api_key, place_id)
      end

      it "returns the formatted reviews data" do
        reviews_data = GoogleReviews::Reviews.fetch_reviews_by_place_id(api_key, place_id)

        reviews_data.data.each_with_index do |review, index|
          expect(review.text).to eq reviews[index]["text"]
        end
      end
    end

    context "when the search ID API returns a successful response without reviews" do
      let(:reviews) { [] }

      it "calls the Utils.request_uri method with the correct arguments" do
        expect(GoogleReviews::Utils).to receive(:request_uri).with(api_key, place_id: place_id)
        GoogleReviews::Reviews.fetch_reviews_by_place_id(api_key, place_id)
      end

      it "calls the ApiRequest.execute method with the correct URL" do
        expect(GoogleReviews::ApiRequest).to receive(:execute).with(url).and_return(data)
        GoogleReviews::Reviews.fetch_reviews_by_place_id(api_key, place_id)
      end

      it "returns an empty array" do
        expect(GoogleReviews::Reviews.fetch_reviews_by_place_id(api_key, place_id).data).to eq([])
      end
    end
  end
end
