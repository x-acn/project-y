class RenameLayoutToTemplateOnPages < ActiveRecord::Migration
  def change
    rename_column :pages, :layout, :template
  end
end
