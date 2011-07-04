require 'spec_helper'

describe PuzzleNode::Scrabble::Word do
  before(:each) do
    @w = PuzzleNode::Scrabble::Word.new("gyre")
    @w2 = PuzzleNode::Scrabble::Word.new('a')
  end

  it "should work with to_s" do
    @w.to_s.should eql("gyre")
  end

  it "should have a possible? method" do
    @w.possible?([PuzzleNode::Scrabble::Tile.new('a7')]).should be_false
    @w2.possible?([PuzzleNode::Scrabble::Tile.new('a7')]).should be_true
    @w.possible?([PuzzleNode::Scrabble::Tile.new('g7'),'y','r','e']).should be_true
  end

  context "with a board" do
    before(:each) do
      @board_array = [
        "1 1 1 1 1",
        "1 1 1 2 1",
        "1 2 1 1 1",
        "2 1 1 1 1",
        "1 1 1 2 1"
      ]
      @board = PuzzleNode::Scrabble::Board.new(@board_array)
    end

    it "should have an array of possible positions" do
      @w.possible_positions(@board).should be_a_kind_of(Array)
    end

    it "should have the right possible positions" do 
      p = @w.possible_positions(@board)
      p.length.should eql(2*5+2*5)
      p.select {|l| l[:orientation] == :horizontal}.length.should eql(10)
      p.select {|l| l[:origin][0] == 0}.length.should eql(7) # 5 vertical + 2 horizontal in row 0
    end
  end
end
