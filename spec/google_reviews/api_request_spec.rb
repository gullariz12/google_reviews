# frozen_string_literal: true

require "google_reviews/api_request"
require "webmock/rspec"

RSpec.describe GoogleReviews::ApiRequest do
  describe ".execute" do
    let(:url) { "https://maps.googleapis.com/maps/api/place/details/json" }
    let(:response_body) { { "status" => "OK", "results" => [] }.to_json }

    before do
      stub_request(:get, url).to_return(body: response_body, status: 200)
    end

    context "when the API request is successful" do
      it "builds the HTTP client with the correct URI" do
        uri = URI(url)
        expect(Net::HTTP).to receive(:new).with(uri.host, uri.port).and_call_original
        GoogleReviews::ApiRequest.execute(url)
      end

      it "builds the HTTP request with the correct URI" do
        uri = URI(url)
        expect(Net::HTTP::Get).to receive(:new).with(uri.request_uri).and_call_original
        GoogleReviews::ApiRequest.execute(url)
      end

      it "sends the HTTP request" do
        expect_any_instance_of(Net::HTTP).to receive(:request).and_call_original
        GoogleReviews::ApiRequest.execute(url)
      end

      it "returns the parsed response body" do
        parsed_response = { "status" => "OK", "results" => [] }
        expect(GoogleReviews::ApiRequest.execute(url)).to eq(parsed_response)
      end
    end

    context "when the API request is unsuccessful" do
      let(:response_code) { 500 }
      let(:response_message) { "Internal Server Error" }
      let(:error_response) { Net::HTTPInternalServerError.new("1.1", response_code, response_message) }

      before do
        allow_any_instance_of(Net::HTTP).to receive(:request).and_return(error_response)
      end

      it "raises an ApiError with the correct error message" do
        error_message = "An error occurred while making the API request: wrong number of arguments (given 0, expected 1)"

        expect do
          GoogleReviews::ApiRequest.execute(url)
        end.to raise_error(GoogleReviews::ApiError, error_message)
      end
    end

    context "when an error occurs during the API request" do
      let(:exception_message) { "Something went wrong" }
      let(:exception) { StandardError.new(exception_message) }

      before do
        allow_any_instance_of(Net::HTTP).to receive(:request).and_raise(exception)
      end

      it "raises an ApiError with the correct error message" do
        error_message = I18n.t("messages.api_request_error", exception: exception_message)
        expect do
          GoogleReviews::ApiRequest.execute(url)
        end.to raise_error(GoogleReviews::ApiError, error_message)
      end
    end

    context "when the response body cannot be parsed as JSON" do
      let(:response_body) { "invalid_json" }

      it "raises an ApiError with the parser error message" do
        error_message = I18n.t("messages.parser_error")
        api_error = "An error occurred while making the API request: Failed to parse the API response"

        expect do
          GoogleReviews::ApiRequest.execute(url)
        end.to raise_error(GoogleReviews::ApiError, api_error)
      rescue GoogleReviews::ApiError => e
        expect(e.message).to eq(error_message)
      end
    end
  end
end
