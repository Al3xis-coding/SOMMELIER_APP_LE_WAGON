class CreateWine < RubyLLM::Tool
  description "Creates a wine record in the database when the user has chosen a specific wine"
  param :categories, desc: "A wine category in this list: fish shellfish poultry pork bbq beef lamb game charcuterie
    soft_cheese aged_cheese blue_cheese
    pasta pizza vegetarian spicy_food asian_cuisine
    dessert chocolate fruit_dessert
    aperitif celebration romantic everyday summer winter
    light_body medium_body full_body
    dry off_dry sweet
    tannic smooth fruity mineral oaky fresh complex
    sparkling fortified"
  param :color, desc: " A wine color in this list: red white rose yellow"
  param :card_content, desc: "The full formatted wine card text you generated for the user (markdown)"
  param :description, desc: "A brief description of the wine: style, winemaking method, unique features, origin"
  param :name, desc: "The name of the wine"
  param :origin, desc: "The origin of the wine: region, country"
  param :price_range, desc: "The estimated retail price range, eg: €10–15"
  param :taste, desc: "List of 3-5 descriptors, eg: red fruit, soft tannins, spicy notes, minerality, bright acidity)"

  def initialize(user, chat)
    @user = user[:id]
    @chat = chat[:id]
  end

  def execute(categories:, color:, description:, name:, origin:, taste:, card_content: nil, price_range: nil)
    Wine.create!(
      user_id: @user,
      chat_id: @chat,
      card_content: card_content,
      categories: [categories],
      color: color,
      description: description,
      name: name,
      origin: origin,
      price_range: price_range,
      taste: taste
    )
  rescue ActiveRecord::RecordNotFound
    { error: "Elements not found" }
  rescue ActiveRecord::RecordInvalid => e
    { error: e.message }
  end
end
