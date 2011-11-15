require 'spec_helper'

describe "sites/index.html.erb" do
  before(:each) do
    assign(:sites, [
      stub_model(Site,
        :subdomain => "Subdomain"
      ),
      stub_model(Site,
        :subdomain => "Subdomain"
      )
    ])
  end

  it "renders a list of sites" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Subdomain".to_s, :count => 2
  end
end
