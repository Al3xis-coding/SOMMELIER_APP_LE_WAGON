module ApplicationHelper
  def render_markdown(text)
    Kramdown::Document.new(text, input: 'GFM', syntax_highlighter: "rouge").to_html
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

  # Strips the structured footer lines from the body so they appear only in the bottom section
  def card_content_body(text)
    text.gsub(/^\*{0,2}(Characteristics|Taste|Food Pairings|Price Range)\*{0,2}:.*$/i, "").strip
  end

  # Extracts the value of a labeled line — handles both "Label: value" and "**Label**: value"
  def card_section(text, label)
    text.match(/^\*{0,2}#{Regexp.escape(label)}\*{0,2}:\s*(.+)/i)&.captures&.first&.strip
  end
end
