class AddMetaInfoToPages < ActiveRecord::Migration
  def change
    add_column :pages, :meta_title, :string
    add_column :pages, :meta_desc, :string
    add_column :pages, :meta_author, :string
  end
end
