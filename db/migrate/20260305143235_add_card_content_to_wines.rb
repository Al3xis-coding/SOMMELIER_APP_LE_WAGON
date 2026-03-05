class AddCardContentToWines < ActiveRecord::Migration[8.1]
  def change
    add_column :wines, :card_content, :text
  end
end
