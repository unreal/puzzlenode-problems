module PuzzleNode
  module Scrabble
    class Board
      attr_reader :spaces
      def initialize(board_array)
        @spaces = Array.new(board_array.length) { Array.new(board_array[0].split(" ").length) }

        board_array.each_index do |row|
          spaces = board_array[row].split(" ")
          spaces.each_index do |column|
            @spaces[row][column] = spaces[column].to_i
          end
        end

      end

      def space(row,column)
        @spaces[row][column]
      end

      def play(row,column,letter)
        @spaces[row][column] = letter
      end

      def row(row)
        @spaces[row]
      end

      def column(column)
        c = []
        (0..(@spaces.length-1)).each do |i|
          c << @spaces[i][column]
        end 
        c
      end

      def possible?(word,origin,orientation)
        case orientation
        when :horizontal
          start_p = origin[1]
          end_p = start_p + word.to_s.length
          return end_p <= self.row(origin[0]).length - 1
        when :vertical
          start_p = origin[0]
          end_p = start_p + word.to_s.length
          return end_p <= self.column(origin[1]).length - 1
        else
          raise ArgumentError, "Invalid Orientation"
        end
      end

      def try(word,position,orientation,game)
        return nil unless possible?(word,position,orientation)

        value = 0

        case orientation
        when :horizontal
          (0..(word.to_s.length-1)).each do |letter_index|
            value += space(position[0],position[1]+letter_index) * game.tile(word.to_s[letter_index]).to_i
          end
        when :vertical
          (0..(word.to_s.length-1)).each do |letter_index|
            value += space(position[0]+letter_index,position[1]) * game.tile(word.to_s[letter_index]).to_i
          end
        else
          raise ArgumentError, "Invalid orientation"
        end

        value
      end

      def to_s
        s = ""
        @spaces.each_index do |row|
          @spaces[row].each_index do |column|
            s += space(row,column).to_s + " "
          end
          s.strip!
          s += "\n"
        end
        s.chomp!
      end
    end
  end
end

