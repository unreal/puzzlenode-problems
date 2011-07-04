require 'json'

module PuzzleNode
  module Scrabble
    class Game
      attr_accessor :board, :dictionary, :tiles
      def initialize(board,dictionary,tiles)
        @board = board
        @dictionary = dictionary
        @tiles = tiles
      end

      # returns the tile object for a given letter
      def tile(letter)
        @tiles.select {|t| t.letter == letter }.first
      end

      # words that can be played with this game's tiles
      def possible_words
        @dictionary.select {|w| w.possible?(@tiles) }
      end

      # returns a hash with the Word, origin, orientation and value of the BEST word (highest score)
      def best_word
        words = []
        possible_words.each do |word|
          word.possible_positions(@board).each do |position|
            value = @board.try(word,position[:origin],position[:orientation],self)
            words << {:word => word, :origin => position[:origin],:orientation => position[:orientation],:value => value.to_i}
          end
        end 
        words.max {|a,b| a[:value] <=> b[:value]}
      end

      # modifies the board array with the given word
      def play(word,position)
        return false unless word.possible?(@tiles)
        return false unless @board.possible?(word,position[:origin],position[:orientation])

        case position[:orientation]
        when :horizontal
          (0..(word.to_s.length-1)).each do |l|
            @board.play(position[:origin][0],position[:origin][1]+l,word.to_s[l])
          end
        when :vertical
          (0..(word.to_s.length-1)).each do |l|
            @board.play(position[:origin][0]+l,position[:origin][1],word.to_s[l])
          end
        else
          raise ArgumentError, "Bad orientation"
        end

        true
      end

      def play_best_word
        play(best_word[:word],{:origin => best_word[:origin],:orientation => best_word[:orientation]})
      end

      def self.from_json_file(json_file)
        j = JSON.parse(json_file.read)
        dictionary = []
        j["dictionary"].each do |w|
          dictionary << PuzzleNode::Scrabble::Word.new(w)
        end
        tiles = []
        j["tiles"].each do |t|
          tiles << PuzzleNode::Scrabble::Tile.new(t)
        end
        return new(
          PuzzleNode::Scrabble::Board.new(j["board"]),
          dictionary,
          tiles
        )
      end
    end
  end
end
