require './blue_hawaii'

input_file = File.new('./input.txt')
rentals_file = File.new('./vacation_rentals.json')
puts PuzzleNode::BlueHawaii.report_from_file(input_file,rentals_file)
