puts "Cleaning database..."
Wine.destroy_all
Chat.destroy_all
User.destroy_all

puts "Creating users..."
alex = User.create!(
  first_name: "alex",
  last_name: "dupont",
  username: "alexdup",
  email: "alex@test.com",
  password: "password",
  tastes: "les vins rouges comlexes et longs en bouche"
)
marie = User.create!(
  first_name: "marie",
  last_name: "durand",
  username: "mariedur",
  email: "marie@test.com",
  password: "password",
  tastes: "les vins blancs rond et beurrés"
)

puts "Creating chat & wines..."
chat = Chat.create!(user: alex)
Wine.create!(
  user: chat.user,
  chat: chat,
  name: "Chablis Premier Cru",
  color: "white",
  origin: "Chablis, Burgundy, France",
  taste: "mineral, citrus, green apple, crisp",
  categories: ["fish", "shellfish", "aperitif", "fresh", "light_body", "dry"],
  description: "From the limestone-rich Kimmeridgian soils of northern Burgundy. Cool climate Chardonnay fermented in stainless steel to preserve purity. Bright acidity, saline minerality, lemon zest and green apple. Excellent with oysters, grilled sea bass and goat cheese.",
)

chat = Chat.create!(user: alex)
Wine.create!(
  user: chat.user,
  chat: chat,
  name: "Barolo DOCG",
  color: "red",
  origin: "Piedmont, Italy",
  taste: "rose, tar, cherry, tannic, complex",
  categories: ["beef", "lamb", "aged_cheese", "complex", "full_body", "tannic", "winter"],
  description: "Produced in the Langhe hills from 100% Nebbiolo. Long maceration and extended oak aging. Aromas of dried rose, tar and sour cherry. Structured tannins with high acidity and long aging potential. Perfect with braised beef, truffle dishes and aged Parmigiano.",
)

chat = Chat.create!(user: marie)
Wine.create!(
  user: chat.user,
  chat: chat,
  name: "Napa Valley Cabernet Sauvignon",
  color: "red",
  origin: "Napa Valley, California, USA",
  taste: "blackcurrant, oak, cocoa, bold",
  categories: ["beef", "bbq", "full_body", "oaky", "complex", "celebration"],
  description: "Mediterranean climate with volcanic soils gives power and ripeness. Aged 18 months in French oak barrels. Deep ruby color, aromas of blackcurrant, vanilla and cocoa. Rich mouthfeel with structured tannins. Ideal for steak and grilled meats.",
)

chat = Chat.create!(user: alex)
Wine.create!(
  user: chat.user,
  chat: chat,
  name: "Sancerre Sauvignon Blanc",
  color: "white",
  origin: "Loire Valley, France",
  taste: "grapefruit, herbal, mineral, fresh",
  categories: ["fish", "vegetarian", "fresh", "light_body", "dry", "summer"],
  description: "Grown on limestone and flint soils along the Loire River. Stainless steel fermentation preserves aromatics. Vibrant acidity with grapefruit, lime zest and flinty notes. Excellent with salads, asparagus and fresh cheeses.",
)

chat = Chat.create!(user: marie)
Wine.create!(
  user: chat.user,
  chat: chat,
  name: "Provence Rosé",
  color: "rose",
  origin: "Provence, France",
  taste: "strawberry, peach, dry, floral",
  categories: ["aperitif", "summer", "vegetarian", "light_body", "fresh", "everyday"],
  description: "Mediterranean vineyards overlooking the sea. Direct press method to preserve delicacy. Pale pink color with aromas of wild strawberry and peach. Crisp and refreshing. Perfect chilled for summer evenings and light dishes.",
)

chat = Chat.create!(user: alex)
Wine.create!(
  user: chat.user,
  chat: chat,
  name: "Sauternes Grand Vin",
  color: "white",
  origin: "Bordeaux, France",
  taste: "honey, apricot, marmalade, rich",
  categories: ["dessert", "blue_cheese", "sweet", "complex", "celebration"],
  description: "Produced with botrytized grapes near the Ciron river. Multiple harvest passes to select noble rot berries. Golden color with aromas of honey, dried apricot and saffron. Luscious texture balanced by vibrant acidity. Ideal with foie gras and fruit desserts.",
)

chat = Chat.create!(user: marie)
Wine.create!(
  user: chat.user,
  chat: chat,
  name: "Champagne Brut",
  color: "white",
  origin: "Champagne, France",
  taste: "brioche, citrus, crisp, mineral",
  categories: ["sparkling", "celebration", "aperitif", "fish", "fresh", "dry"],
  description: "Traditional method sparkling wine from chalky soils. Blend of Chardonnay, Pinot Noir and Pinot Meunier. Aged on lees for complexity. Fine bubbles, citrus zest, toasted brioche and mineral finish. Perfect for celebrations and seafood.",
)

chat = Chat.create!(user: alex)
Wine.create!(
  user: chat.user,
  chat: chat,
  name: "Rioja Crianza",
  color: "red",
  origin: "Rioja, Spain",
  taste: "cherry, vanilla, spice, smooth",
  categories: ["pork", "charcuterie", "medium_body", "smooth", "oaky", "everyday"],
  description: "Tempranillo aged in American oak barrels for 12 months. Aromas of red cherry, vanilla and sweet spice. Balanced acidity with soft tannins. Excellent with grilled pork, tapas and cured meats.",
)

puts "✅ Created #{Wine.count} wines"
