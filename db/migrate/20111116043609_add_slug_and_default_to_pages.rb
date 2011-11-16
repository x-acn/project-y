class AddSlugAndDefaultToPages < ActiveRecord::Migration
  def change
    add_column :pages, :slug, :string
    add_column :pages, :default, :boolean
    
    Page.reset_column_information
 
    Page.all.each do |page|
      page.default = false
      page.slug = to_slug(page.title)
      page.save!
    end
    
  end
end
