module PuzzleNode
  module Scrabble
    class Word
      def initialize(word)
        @word = word
      end

      def to_s
        @word
      end

      def possible?(tiles)
        used = []
        letters = tiles.collect{|t| t.to_s } # only care about letters
        @word.to_s.each_char do |c|
          if letters.include?(c)
            used << letters.delete_at(letters.index(c))
          else
            return false
          end
        end
        true
      end

      def possible_positions(board)
        positions = []
        # horizontal
        if @word.to_s.length <= board.row(0).length
          (0..(board.row(0).length-@word.to_s.length)).each do |c|
            (0..(board.column(0).length-1)).each do |r|
              positions << {:origin => [r,c],:orientation => :horizontal}
            end
          end
        end

        # vertical
        if @word.to_s.length <= board.column(0).length
          (0..(board.row(0).length-1)).each do |c|
            (0..(board.column(0).length-@word.to_s.length)).each do |r|
              positions << {:origin => [r,c],:orientation => :vertical}
            end
          end
        end
        positions
      end
    end
  end
end

