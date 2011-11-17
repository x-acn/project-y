class AddContentsToPages < ActiveRecord::Migration
  def change
    add_column :pages, :contents, :text
  end
end
