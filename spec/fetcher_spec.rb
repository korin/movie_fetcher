require 'spec_helper'
require 'timecop'

RSpec.describe MovieFetcher do
  it "shows movie details" do
    class MovieFetcher::Fetcher
      def get_google_html
        @doc = File.read File.join(File.dirname(__FILE__), 'fixtures/movies.html')
      end
    end

    Timecop.travel(2015, 7, 14, 16, 5, 0) do
      result = MovieFetcher::Fetcher.new.fetch
      expect(result).to include "Agentka, Multikino Ursynów, 16:10"
    end
  end
end

