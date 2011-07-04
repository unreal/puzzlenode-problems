require 'spec_helper'

describe PuzzleNode::Scrabble::Game do
  before(:each) do
    @g = PuzzleNode::Scrabble::Game.new(PuzzleNode::Scrabble::Board.new(["1"]),[],[])
  end

  it "should have a board" do
    @g.board.should be_a_kind_of(PuzzleNode::Scrabble::Board)
  end

  it "should have a dictionary array" do
    @g.dictionary.should be_a_kind_of(Array)
  end

  it "should have a tiles array" do
    @g.tiles.should be_a_kind_of(Array)
  end

  it "should be able to lookup a tile by letter" do
    @g.tiles = [PuzzleNode::Scrabble::Tile.new('a1')]
    @g.tile('a').to_i.should eql(1)
  end

  context "words" do
    before(:each) do
      @g.tiles = [PuzzleNode::Scrabble::Tile.new('a1')]
      @g.dictionary = [PuzzleNode::Scrabble::Word.new('a'),PuzzleNode::Scrabble::Word.new('b')]
    end

    it "should have an array of possible words" do
      @g.possible_words.should be_a_kind_of(Array)
    end

    it "should return the correct possible words" do
      @g.possible_words.first.to_s.should eql('a')
    end

    it "should not matter if i call possible_words twice" do
      2.times do
        @g.possible_words.first.to_s.should eql("a")
      end
    end

    context "sample letters" do
      before(:each) do
        ['c','d'].each do |l|
          @g.dictionary << PuzzleNode::Scrabble::Word.new(l)
        end
        ['c1','b1','a7','d1'].each do |t|
          @g.tiles << PuzzleNode::Scrabble::Tile.new(t)
        end

      end

      it "should have 4 possible words" do
        @g.possible_words.length.should eql(4)
      end

      it "should have a best word" do
        @g.best_word.should_not be_nil
      end
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
        @g.board = @board
      end

      it "should let me play a word if it's possible with current tiles and possible to play on board" do
        @g.play(@g.dictionary.first,{:origin => [0,0],:orientation => :horizontal}).should be_true
      end 
    end
  end

  context "JSON" do
    before(:each) do
      @input_file = File.new(File.join(File.dirname(__FILE__),'fixtures/EXAMPLE_INPUT.json'))
    end

    it "should let me create a new game from JSON" do
      @g = PuzzleNode::Scrabble::Game.from_json_file(@input_file).should be_a_kind_of(PuzzleNode::Scrabble::Game)
    end

    context "from sample JSON file" do
      before(:each) do
        @g = PuzzleNode::Scrabble::Game.from_json_file(@input_file)
      end

      it "should have the right board" do
        @g.board.spaces.length.should eql(9)
      end

      it "should have 31 words in the dictionary" do
        @g.dictionary.length.should eql(31)
      end

      it "should have 20 tiles" do
        @g.tiles.length.should eql(20)
      end

      it "should be possible to play whiffling with these tiles" do
        w = @g.dictionary.select {|w| w.to_s == "whiffling"}.first
        w.possible?(@g.tiles).should be_true
      end

      it "should have whiffling in its possible words" do
        @g.possible_words.length.should be > 0 
        words = @g.possible_words.collect{ |w| w.to_s }
        words.include?("whiffling").should be_true
      end

      it "should have whiffling as the best word" do
        @g.best_word[:word].to_s.should eql("whiffling")
      end

      it "should have the correct board after playing the best word" do
        example_output = File.new(File.join(File.dirname(__FILE__),'fixtures/EXAMPLE_OUTPUT.txt')).read
        @g.play_best_word
        @g.board.to_s.should eql(example_output)
      end
    end
  end
end


