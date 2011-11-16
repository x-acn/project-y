class AddRawToPages < ActiveRecord::Migration
  def change
    add_column :pages, :raw, :text
  end
end
