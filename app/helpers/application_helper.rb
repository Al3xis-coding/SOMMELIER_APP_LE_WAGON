module ApplicationHelper
  def render_markdown(text)
    Kramdown::Document.new(normalize_wine_message(text), input: 'GFM', syntax_highlighter: "rouge").to_html
  end

  # Fixes missing newlines that the LLM tends to omit in wine recommendation blocks
  def normalize_wine_message(text)
    text
      # Split ### heading from flag emoji (subtitle) when on the same line
      .gsub(/(###[^\n\u{1F1E0}-\u{1F1FF}]+)([\u{1F1E0}-\u{1F1FF}]{2})/, "\\1\n\n\\2")
      # Split flag/origin line from description when run together (lowercase → uppercase with no space)
      .gsub(/([\u{1F1E0}-\u{1F1FF}]{2}[^\n]+?)([a-z])([A-Z])/) { "#{$1}#{$2}\n\n#{$3}" }
      # Split Taste and Price when crammed onto the same line
      .gsub(/(\*{0,2}Taste\*{0,2}:[^\n]+?)(\*{0,2}Price\*{0,2}:)/i) { "#{$1}\n#{$2}" }
      # Ensure --- separator is on its own line (not glued to price or other text)
      .gsub(/([^\n])---/, "\\1\n\n---")
  end

  FLAGS = {
    # Western Europe
    "france"          => "🇫🇷", "italy"           => "🇮🇹", "spain"           => "🇪🇸",
    "portugal"        => "🇵🇹", "germany"         => "🇩🇪", "austria"         => "🇦🇹",
    "switzerland"     => "🇨🇭", "luxembourg"      => "🇱🇺", "belgium"         => "🇧🇪",
    "england"         => "🇬🇧", "uk"              => "🇬🇧", "united kingdom"  => "🇬🇧",
    # Southern & Eastern Europe
    "greece"          => "🇬🇷", "cyprus"          => "🇨🇾", "turkey"          => "🇹🇷",
    "hungary"         => "🇭🇺", "romania"         => "🇷🇴", "bulgaria"        => "🇧🇬",
    "croatia"         => "🇭🇷", "slovenia"        => "🇸🇮", "serbia"          => "🇷🇸",
    "slovakia"        => "🇸🇰", "czech republic"  => "🇨🇿", "czechia"         => "🇨🇿",
    "montenegro"      => "🇲🇪", "north macedonia" => "🇲🇰", "albania"         => "🇦🇱",
    "ukraine"         => "🇺🇦",
    # Caucasus & Middle East
    "georgia"         => "🇬🇪", "armenia"         => "🇦🇲", "azerbaijan"      => "🇦🇿",
    "moldova"         => "🇲🇩", "israel"          => "🇮🇱", "lebanon"         => "🇱🇧",
    # Africa
    "morocco"         => "🇲🇦", "tunisia"         => "🇹🇳", "algeria"         => "🇩🇿",
    "south africa"    => "🇿🇦",
    # Americas
    "usa"             => "🇺🇸", "united states"   => "🇺🇸", "canada"          => "🇨🇦",
    "argentina"       => "🇦🇷", "chile"           => "🇨🇱", "uruguay"         => "🇺🇾",
    "brazil"          => "🇧🇷", "mexico"          => "🇲🇽", "peru"            => "🇵🇪",
    # Asia-Pacific
    "australia"       => "🇦🇺", "new zealand"     => "🇳🇿", "japan"           => "🇯🇵",
    "china"           => "🇨🇳", "india"           => "🇮🇳"
  }.freeze

  def country_flag(origin)
    return "" if origin.blank?
    country = origin.split(",").last.strip.downcase
    FLAGS[country] || ""
  end

  # Strips heading lines, origin/flag lines, and footer labels so they appear only in their dedicated sections
  def card_content_body(text)
    text
      .gsub(/^#+\s+.*$/, "")
      .gsub(/^\p{Regional_Indicator}{2}.*$/, "")
      .gsub(/^\*{0,2}(Characteristics|Taste|Food Pairings|Price Range)\*{0,2}:.*$/i, "")
      .strip
  end

  # Extracts the value of a labeled line — handles both "Label: value" and "**Label**: value"
  def card_section(text, label)
    text.match(/^\*{0,2}#{Regexp.escape(label)}\*{0,2}:\s*(.+)/i)&.captures&.first&.strip
  end
end
