module PuzzleNode
  module Scrabble
    class Tile
      attr_reader :letter, :value
      def initialize(s)
        @letter = s.gsub(/\d/,'')
        @value = s.gsub(/\D/,'').to_i
      end

      def to_i
        @value
      end

      def to_s
        @letter
      end
    end
  end
end
