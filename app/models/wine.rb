class Wine < ApplicationRecord
  CATEGORIES = %w[
    fish shellfish poultry pork bbq beef lamb charcuterie
    soft_cheese aged_cheese blue_cheese
    pasta pizza vegetarian spicy_food asian_cuisine
    dessert chocolate fruit
    aperitif celebration romantic everyday summer winter
  ].freeze

  COLORS = %w[red white rose yellow].freeze

  belongs_to :user
  belongs_to :chat

  validates :color, presence: true, inclusion: { in: COLORS }
  validates :categories, presence: true, inclusion: { in: CATEGORIES }
end
