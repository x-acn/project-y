require 'spec_helper'

describe Domain do

  let(:domain) { Factory(:domain) }
  
  it "should be valid with valid required fields" do
    domain.should be_valid
  end
  
  it "should not be valid without a domain" do
    domain.domain = ''
    domain.should_not be_valid
  end
  
  describe "site association" do
    it "should belong to a site" do
      domain.site.should_not be_nil
    end
    
    it "should not allow creation without a site" do
      expect { Factory(:domain, :site=>nil) }.to raise_error(ActiveRecord::RecordInvalid)
    end
    
    it "should get deleted when the site is deleted" do
      domain.site.destroy
      expect{ Domain.find(domain.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
    
    it "should not allow mass-assignment of site_id" do
      params = {:site_id => 1 }
      domain = Domain.create(params)
      domain.site_id.should be_nil
    end
  end
  
end
