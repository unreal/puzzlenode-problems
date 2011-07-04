module PuzzleNode
  module BlueHawaii
    class Season
      attr_reader :name, :rate, :end_date, :start_date
      def initialize(name,rate,start_d,end_d)
        @name = name
        @start_date = Date.parse("2011-#{start_d}")
        @end_date = Date.parse("2011-#{end_d}")
        @rate = (rate.class == String ? Money.new(rate.gsub(/\D/,'').to_i * 100) : Money.new(rate))
      end
    end
  end
end
