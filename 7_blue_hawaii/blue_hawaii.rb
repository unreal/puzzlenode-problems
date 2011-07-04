require 'rubygems'
require 'bundler/setup'

require 'json'
require 'money'

$LOAD_PATH.unshift File.join(File.dirname(__FILE__)) 

require 'blue_hawaii/rental'
require 'blue_hawaii/season'

module PuzzleNode
  module BlueHawaii
    class << self
      def load(file)
        JSON.parse(file.read)
      end

      def process(rentals_array)
        @rentals = []
        rentals_array.each do |rental_json|
          @rentals << Rental.from_json(rental_json)
        end
        @rentals
      end

      def report(rentals,start_d,end_d)
        string = ''
        @rentals.each do |r|
          string += "#{r.name}: $#{r.total(start_d,end_d)}\n"
        end
        string
      end

      def report_from_file(file,rentals_file)

        # parse the start and end date
        m = file.read.match(/(\d{4}\/\d{2}\/\d{2}) \- (\d{4}\/\d{2}\/\d{2})/)
        start_d = Date.parse(m[1])
        end_d = Date.parse(m[2])

        r = load(rentals_file)
        rentals = process(r)
        report(rentals,start_d.strftime("%m-%d"),end_d.strftime("%m-%d")).strip
      end
    end
  end
end
