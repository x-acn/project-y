class AddTitleToSites < ActiveRecord::Migration
  def change
    add_column :sites, :title, :string
  end
end
