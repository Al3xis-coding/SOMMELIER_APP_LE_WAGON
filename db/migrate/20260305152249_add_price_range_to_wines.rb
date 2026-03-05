class AddPriceRangeToWines < ActiveRecord::Migration[8.1]
  def change
    add_column :wines, :price_range, :string
  end
end
