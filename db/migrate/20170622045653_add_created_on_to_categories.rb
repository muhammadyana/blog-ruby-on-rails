class AddCreatedOnToCategories < ActiveRecord::Migration[5.1]
  def change
  	add_column :categories, :created_on, :string
  end
end
