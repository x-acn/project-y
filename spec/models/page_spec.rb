require 'spec_helper'

describe Page do
  
  let(:page) { Factory(:page) }
  
  it "should be valid with valid required fields" do
    page.should be_valid
  end
  
  it "should not be valid without a title" do
    page.title = ''
    page.should_not be_valid
  end
  
  
  describe "site association" do
    it "should belong to a site" do
      page.site.should_not be_nil
    end
    
    it "should not allow creation without a site" do
      expect { Factory(:page, :site=>nil) }.to raise_error(ActiveRecord::RecordInvalid)
    end
    
    it "should get deleted when the site is deleted" do
      page.site.destroy
      expect{ Page.find(page.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
    
    it "should not allow mass-assignment of site_id" do
      params = {:site_id => 1 }
      page = Page.create(params)
      page.site_id.should be_nil
    end
  end
  
end
