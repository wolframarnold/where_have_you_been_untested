require 'spec_helper'

describe Trip do

  it 'must have a name' do
    t = Trip.new
    #t.valid?.should be_false
    t.should_not be_valid
    t.errors[:name].should_not be_empty
  end

  describe "When Start and End Dates are used" do
    it 'if start date is given, then end date must also be given' do
      t = Trip.new(:begun_on => 1.year.ago)
      t.should_not be_valid
      t.errors[:ended_on].should_not be_empty
    end
    it 'if end date is given, then start date must be given' do
      t = Trip.new(:ended_on => 1.year.ago)
      t.should_not be_valid
      t.errors[:begun_on].should_not be_empty
    end
  end

  describe "Scopes" do
    before do
      Time.stub!(:now).and_return(Time.utc(2011,12,31))
      @t1 = FactoryGirl.create(:trip, :created_at => 1.year.ago)
      @t2 = FactoryGirl.create(:trip, :created_at => 2.years.ago)
      @t3 = FactoryGirl.create(:trip, :created_at => 6.months.ago)
    end

    it '"desc" should sort by date, descending order' do
      Trip.should respond_to(:desc)
      #.desc  ... should ....
      Trip.desc.all.should == [@t3,@t1,@t2]
    end

    it '"last_12_months" returns only trips this year' do
      Trip.last_12_months.all.should == [@t3]
    end
  end



end