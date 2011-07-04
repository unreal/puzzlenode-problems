module PuzzleNode
  module BlueHawaii
    class Rental
      attr_reader :name, :cleaning_fee, :rate
      attr_accessor :seasons

      SALES_TAX = 4.11416

      def initialize(name)
        @name = name
        @seasons = []
        @cleaning_fee = Money.new(0)
        @rate = Money.new(0)
      end


      def cleaning_fee=(cents)
        @cleaning_fee = cents.class == String ? Money.new(cents.gsub(/\D/,'').to_i * 100) : Money.new(cents)
      end

      def rate=(cents)
        @rate = cents.class == String ? Money.new(cents.gsub(/\D/,'').to_i * 100) : Money.new(cents)
      end

      def season(date)
        d = Date.parse("2011-#{date}")
        @seasons.select { |s| s.start_date > s.end_date ? (d >= s.start_date && d <= Date.parse('2011-12-31') || d >= Date.parse('2011-01-01') && d <= s.end_date ) : s.start_date <= d && s.end_date >= d}.first
      end

      def rate(date)
        return @rate if season(date).nil?

        season(date).rate
      end

      def room_fee(start_d,end_d)
        start_date = Date.parse("2011-#{start_d}")
        end_date = Date.parse("2011-#{end_d}") - 1 # don't charge the last day

        fee = Money.new(0)
        start_date.upto(end_date).each do |day|
          fee += rate(day.strftime("%m-%d"))
        end
        fee
      end

      def subtotal(start_d,end_d)
        room_fee(start_d,end_d) + cleaning_fee
      end

      def total(start_d,end_d)
        subtotal(start_d,end_d) * (1.0 + SALES_TAX/100.0)
      end


      class << self
        def from_json(json)
          @rental = new(json["name"])

          if json["seasons"].nil?
            @rental.rate = json["rate"]
          else
            json["seasons"].each do |season|
              season.each_pair do |season_name,season_info|
                @rental.seasons << BlueHawaii::Season.new(season_name,season_info["rate"],season_info["start"],season_info["end"])
              end
            end
          end

          @rental.cleaning_fee = json["cleaning fee"] unless json["cleaning fee"].nil?

          @rental
        end
      end
    end
  end
end
