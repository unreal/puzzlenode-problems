require 'spec_helper'


describe PuzzleNode::BlueHawaii do

  it "should have a load class method" do
    PuzzleNode::BlueHawaii.respond_to?(:load).should be_true
  end

  it "should have a process class method" do
    PuzzleNode::BlueHawaii.respond_to?(:process).should be_true
  end

  context "result" do
    before(:each) do
      f = File.new(File.join(File.dirname(__FILE__),'fixtures/sample_vacation_rentals.json'))
      @r = PuzzleNode::BlueHawaii.load(f) 
    end

    it "should return an array" do
      @r.should be_a_kind_of(Array)
    end

    it "should have 3 rental units" do
      @r.length.should eql(3)
    end
  end

  context "process" do
    before(:each) do
      f = File.new(File.join(File.dirname(__FILE__),'fixtures/sample_vacation_rentals.json'))
      r = PuzzleNode::BlueHawaii.load(f)
      @rentals = PuzzleNode::BlueHawaii.process(r)
    end


    it "should come back with 3 rentals" do
      @rentals.length.should eql(3)
    end
  end

  context "report from file" do

    it "should output the right report" do
      input_file = File.new(File.join(File.dirname(__FILE__),'fixtures/sample_input.txt'))
      rentals_file = File.new(File.join(File.dirname(__FILE__),'fixtures/sample_vacation_rentals.json'))
      output_file = File.new(File.join(File.dirname(__FILE__),'fixtures/sample_output.txt'))
      PuzzleNode::BlueHawaii.report_from_file(input_file,rentals_file).should eql(output_file.read)
    end
  end
end

