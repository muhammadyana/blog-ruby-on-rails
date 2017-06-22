class AddTitleToArticles < ActiveRecord::Migration[5.1]
  def change
  	add_column :articles, :meta_title, :text
  	add_column :articles, :meta_keyword, :text
  	
  end
end
