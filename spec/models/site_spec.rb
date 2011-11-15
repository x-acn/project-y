require 'spec_helper'

describe Site do
  
  let(:site) { Factory(:site) }
  
  it "should be valid with valid required fields" do
    site.should be_valid
  end
  
  it "should not be valid without a subdomain" do
    site.subdomain = ''
    site.should_not be_valid
  end
  
  describe "domain association" do
    it "should have domains" do
      site.domains.is_a? Enumerable
    end
    
    it "should be searchable by domain" do
      
    end
  end
  
#  describe "user association" do
#    it "should have a user" do
#      workout.user.should_not be_nil
#    end
#    
#    it "should not allow creation without a user" do
#      expect { Fabricate(:workout, :user=>nil) }.to raise_error(ActiveRecord::RecordInvalid)
#    end
#    
#    it "should get deleted when the user is deleted" do
#      user = workout.user
#      user.destroy
#      expect{ Workout.find(workout.id) }.to raise_error(ActiveRecord::RecordNotFound)
#    end
#  end
  
end
