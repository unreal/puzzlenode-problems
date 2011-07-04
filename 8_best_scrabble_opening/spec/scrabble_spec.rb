require 'spec_helper'

describe PuzzleNode::Scrabble do
  before(:each) do
    @input_file = File.new(File.join(File.dirname(__FILE__),'fixtures/EXAMPLE_INPUT.json'))
    @output_file = File.new(File.join(File.dirname(__FILE__),'fixtures/EXAMPLE_OUTPUT.txt'))
  end

  it "should have a #solve method that returns the output from the example output" do
    PuzzleNode::Scrabble.solve(@input_file).should eql(@output_file.read)
  end
end
