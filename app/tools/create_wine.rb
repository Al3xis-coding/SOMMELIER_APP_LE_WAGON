class CreateWine < RubyLLM::Tool
  description "Creates a wine record in the database when the user has chosen a specific wine"
  param :categories, desc: "A wine category in this list: fish shellfish poultry pork bbq beef lamb game charcuterie"
  param :color, desc: " A wine color in this list: red white rose yellow"
  param :description, desc: "A brief description of the wine: style, winemaking method, unique features, origin"
  param :name, desc: "The name of the wine"
  param :origin, desc: "The origin of the wine: region, country"
  param :taste, desc: "List of 3-5 descriptors, eg: red fruit, soft tannins, spicy notes, minerality, bright acidity)"

  def initialize(user, chat)
    @user = user[:id]
    @chat = chat[:id]
  end

  def execute(categories:, color:, description:, name:, origin:, taste:)
    Wine.create!(
      user_id: @user,
      chat_id: @chat,
      categories: [categories],
      color: color,
      description: description,
      name: name,
      origin: origin,
      taste: taste
    )
  rescue ActiveRecord::RecordNotFound
    { error: "Elements not found" }
  rescue ActiveRecord::RecordInvalid => e
    { error: e.message }
  end
end
