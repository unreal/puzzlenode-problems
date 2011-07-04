require 'spec_helper'

describe PuzzleNode::BlueHawaii::Season do
  before(:each) do
    @s = PuzzleNode::BlueHawaii::Season.new('test',10000,"05-06","05-13")
  end

  it "should have a name" do
    @s.name.should eql('test')
  end

  it "should have the right start date" do
    @s.start_date.should eql(Date.parse("2011-05-06"))
  end

  it "should have the right end date" do
    @s.end_date.should eql(Date.parse("2011-05-13"))
  end

  it "should have the right rate" do
    @s.rate.cents.should eql(10000)
  end
end

