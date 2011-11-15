require 'spec_helper'


describe User do
  
  before(:each) do
    @user = FactoryGirl.build(:user)
  end
    
  it "should authenticate with matching email and password" do
    @user.authenticate('test').should == @user 
  end
  
  it "should not authenticate with incorrect password" do
    @user.authenticate('invalid').should be_false
  end
  
  it "should not create user with duplicate email" do
    lambda { User.create!(:email => @user.email, :password => '123') }.should raise_error(ActiveRecord::RecordInvalid, /email is invalid/i)
  end
  
  it "should not accept invalid email address" do
    @user.email = 'hello'
    lambda { @user.save! }.should raise_error(ActiveRecord::RecordInvalid, /email is invalid/i)
  end
  
end
