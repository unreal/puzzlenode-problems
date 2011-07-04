require 'rubygems'
require 'bundler/setup'


$LOAD_PATH.unshift File.join(File.dirname(__FILE__)) 

require 'scrabble/board'
require 'scrabble/game'
require 'scrabble/tile'
require 'scrabble/word'

module PuzzleNode
  module Scrabble
    class << self
      # provides a method for creating a game from JSON,
      # playing the first move, and returns the board
      def solve(input_file)
        @g = PuzzleNode::Scrabble::Game.from_json_file(input_file)
        @g.play_best_word
        return @g.board.to_s
      end
    end
  end
end
