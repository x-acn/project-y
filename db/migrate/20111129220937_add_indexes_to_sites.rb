class AddIndexesToSites < ActiveRecord::Migration
  def change
    add_index :sites, :subdomain
  end
end
