require 'spec_helper'

describe PuzzleNode::Scrabble::Board do
  before(:each) do
    @board_array = [
      "1 1 1 1 1 1 1 1 1 1 1 1",
      "1 1 1 2 1 2 1 1 1 1 1 1",
      "1 2 1 1 1 3 1 1 1 1 2 1",
      "2 1 1 1 1 1 1 1 1 2 2 1",
      "1 1 1 2 1 1 1 1 1 1 1 1",
      "1 1 1 1 1 1 2 1 1 1 2 1",
      "1 1 1 1 1 1 1 1 2 1 1 1",
      "1 1 1 1 1 1 1 1 1 1 1 2",
      "1 1 1 1 1 1 1 1 1 1 1 1"
    ]
    @board = PuzzleNode::Scrabble::Board.new(@board_array)
  end

  it "should have an Array of spaces" do
    @board.spaces.should be_a_kind_of(Array)
  end

  it "should have 12x9 spaces" do
    @board.spaces.length.should eql(9)
    @board.spaces[0].length.should eql(12)
  end

  it "should find the value of a space by row and column" do
    @board.space(0,0).should eql(1)
    @board.space(3,0).should eql(2)
  end

  it "should have a try method" do
    @board.respond_to?(:try).should be_true
  end

  it "should be able to return a row" do
    @board.row(0).should eql(@board_array[0].split(" ").collect!{|s| s.to_i})
  end

  it "should be able to return a column" do
    @board.column(0).should eql([1,1,1,2,1,1,1,1,1])
  end

  it "should have a to_s method" do
    board_array = ['1 1',
                   '1 1']
    b = PuzzleNode::Scrabble::Board.new(board_array)
    b.to_s.should eql("1 1\n1 1")
  end

  context "with word" do
    before(:each) do
      @w = PuzzleNode::Scrabble::Word.new('test')
    end

    it "should have a possible? method that tells if a word can fit in the given orientation" do
      @board.possible?(@w,[0,0],:horizontal).should be_true
      @board.possible?(@w,[0,7],:horizontal).should be_true
      @board.possible?(@w,[0,8],:horizontal).should be_false

      @board.possible?(@w,[1,0],:vertical).should be_true
      @board.possible?(@w,[4,0],:vertical).should be_true
      @board.possible?(@w,[5,0],:vertical).should be_false
    end

    it "should return nil on a try if the word is impossible" do
      g = double(PuzzleNode::Scrabble::Game)
      @board.try(@w,[0,8],:horizontal,g)
    end

    it "should return a value if the word is possible" do
      g = double(PuzzleNode::Scrabble::Game)
      g.should_receive(:tile).exactly(4).times.and_return(1)
      @board.try(@w,[0,0],:horizontal,g).should eql(4)
    end

  end
end


