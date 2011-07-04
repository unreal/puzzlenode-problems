require './scrabble'

input_file = File.new('./INPUT.json')
puts PuzzleNode::Scrabble.solve(input_file)

