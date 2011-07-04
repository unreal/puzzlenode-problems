require 'spec_helper'

describe PuzzleNode::Scrabble::Tile do
  before(:each) do
    @t = PuzzleNode::Scrabble::Tile.new('i4')
  end

  it "should have be just i when to_s" do
    @t.to_s.should eql('i')
  end

  it "should have a value of 4" do
    @t.to_i.should eql(4)
  end
end
