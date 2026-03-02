class CreateWines < ActiveRecord::Migration[8.1]
  def change
    create_table :wines do |t|
      t.references :user, null: false, foreign_key: true
      t.references :chat, null: false, foreign_key: true
      t.string :origin
      t.text :description
      t.string :color
      t.string :categories

      t.timestamps
    end
  end
end
