class Wine < ApplicationRecord
  CATEGORIES = %w[
    fish shellfish poultry pork beef lamb game charcuterie
    soft_cheese aged_cheese blue_cheese
    pasta pizza vegetarian spicy_food asian_cuisine
    dessert chocolate fruit_dessert
    aperitif celebration romantic everyday summer winter
    light_body medium_body full_body
    dry off_dry sweet
    tannic smooth fruity mineral oaky fresh complex
    sparkling fortified
  ].freeze

  COLORS = %w[red white rose yellow].freeze

  belongs_to :user
  belongs_to :chat
  validates :color, presence: true, inclusion: { in: COLORS }
  validates :categories, presence: true, inclusion: { in: CATEGORIES }
end
