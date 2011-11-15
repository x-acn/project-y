class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.integer :site_id
      t.string :domain

      t.timestamps
    end
  end
end
