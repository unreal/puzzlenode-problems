require 'spec_helper'

describe PuzzleNode::BlueHawaii do
  describe PuzzleNode::BlueHawaii::Rental do
    before(:each) do
      @r = PuzzleNode::BlueHawaii::Rental.new('test')
    end

    it "should have a name" do
      @r.name.should eql('test')
    end

    it "should have an array of seasons" do
      @r.seasons.should be_a_kind_of(Array)
    end

    it "should have a cleaning fee" do
      @r.cleaning_fee.should be_a_kind_of(Money)
      @r.cleaning_fee.cents.should eql(0)
    end

    it "should have the sales tax" do
      PuzzleNode::BlueHawaii::Rental::SALES_TAX.should eql(4.11416)
    end

    context "class method creation" do
      before(:each) do
        json = '{"name":"Fern Grove Lodge","seasons":[{"one":{"start":"05-01","end":"05-13","rate":"$137"}},{"two":{"start":"05-14","end":"04-30","rate":"$220"}}],"cleaning fee":"$98"}'
        json = JSON.parse(json)
        @r = PuzzleNode::BlueHawaii::Rental.from_json(json)
      end

      it "should have the right name" do
        @r.name.should eql("Fern Grove Lodge")
      end

      it "should have two seasons" do
        @r.seasons.length.should eql(2)
      end

      it "should have a rate of 137 for the first season" do
        @r.seasons.first.rate.cents.should eql(13700)
      end

      it "should have a cleaning fee of $98" do
        @r.cleaning_fee.cents.should eql(9800)
      end
    end

    context "seasons" do
      context "that wrap the year" do
        before(:each) do
          @r.seasons = []
          @r.seasons << PuzzleNode::BlueHawaii::Season.new('one',10000,'03-01','03-05')
          @r.seasons << PuzzleNode::BlueHawaii::Season.new('two',20000,'03-06','02-28')
        end

        it "should return the right season" do
          @r.season('01-02').should eql(@r.seasons.last)
          @r.season('03-03').should eql(@r.seasons.first)
        end
      end
      before(:each) do
        @r.seasons << PuzzleNode::BlueHawaii::Season.new('one',10000,'01-01','05-31')
        @r.seasons << PuzzleNode::BlueHawaii::Season.new('two',20000,'06-01','12-31')
      end

      it "should return the correct season for a date" do

        @r.season('01-01').should eql(@r.seasons.first)
        @r.season('11-11').should eql(@r.seasons.last)
      end

      it "sould not return a season if there are none" do
        @r.seasons = []
        @r.season('01-01').should be_nil
      end

      it "should return the correct rate for a given date based on its seasons" do
        @r.rate('01-01').cents.should eql(10000)
        @r.rate('02-01').cents.should eql(10000)
        @r.rate('05-31').cents.should eql(10000)
        @r.rate('06-01').cents.should eql(20000)
        @r.rate('08-15').cents.should eql(20000)
        @r.rate('12-31').cents.should eql(20000)
      end

      it "should return the standard rate if there are no seasons" do
        @r.seasons = []
        @r.rate('01-01').cents.should eql(0)
      end

      it "should give the right room fee for a date range" do
        @r.room_fee("01-01","01-02").cents.should eql(10000)
        @r.room_fee("05-31","06-02").cents.should eql(30000)
      end

      it "should have the correct subtotal" do
        @r.cleaning_fee = 10000
        @r.subtotal("05-31","06-02").cents.should eql(40000)
      end

      it "should have the correct total cost" do
        @r.cleaning_fee = 10000
        @r.total("05-31","06-02").cents.should eql(41646)
      end
    end
  end
end
