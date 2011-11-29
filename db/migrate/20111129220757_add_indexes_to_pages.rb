class AddIndexesToPages < ActiveRecord::Migration
  def change
    add_index :pages, :site_id
    #choosing not to index the page slugs or the default page
    #under the assumption that the site_id index should bring it to within 1-5 records
  end
end
