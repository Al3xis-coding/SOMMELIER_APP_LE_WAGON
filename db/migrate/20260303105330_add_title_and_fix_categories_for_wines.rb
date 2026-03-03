class AddTitleAndFixCategoriesForWines < ActiveRecord::Migration[8.1]
  def change
    add_column :wines, :name, :string
    add_column :wines, :taste, :string
    remove_column :wines, :categories, :string
    add_column :wines, :categories, :string, array: true, default: []
  end
end
