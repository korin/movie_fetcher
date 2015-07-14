require 'open-uri'
require 'nokogiri'

module MovieFetcher
  class Fetcher
    def initialize(endpoint = nil)
      @endpoint = endpoint ||
        "https://www.google.pl/movies?hl=pl&near=Warszawa&dq=filmy+warszawa&sort=1&q=filmy&sa=X&ved=0CB4QxQMoAGoVChMIs-DMheDaxgIVQXdyCh3tcwCJ"
    end

    def fetch
      get_google_html
      parse_html
      find_closest_movie
    end

    private

    def get_google_html
      @doc = open(@endpoint)
    end

    def parse_html
      @showtimes = []
      doc = Nokogiri::HTML(@doc)
      movies = doc.css(".movie")
      movies.each do |movie|
        name = movie.css('[itemprop="name"] a').first.content
        movie.css('.theater').each do |theater|
          theater_name = theater.css('.name a').first.content
          theater.css('.times span').each do |start_time|
            time = start_time.content
            if time =~ /(\d\d:\d\d)/ && $1
              @showtimes << Showtime.new(name, theater_name, $1)
            end
          end
        end
      end
    end

    def sort_showtimes
      @showtimes.sort do |p, n|
        p.time <=> n.time
      end
    end

    def find_closest_movie
      now = Time.now.strftime('%H:%m')
      earliest_show_time = nil
      sort_showtimes.reject do |showtime|
        too_early =  showtime.time < now
        earliest_show_time ||= !too_early && showtime.time
        too_early || ( earliest_show_time && showtime.time > earliest_show_time )
      end.map &:to_s
    end

    class Showtime < Struct.new(:name, :theater, :time)
      def to_s
        "#{name}, #{theater}, #{time}"
      end
    end

  end
end
