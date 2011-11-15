class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :site

      t.timestamps
    end
  end
end
