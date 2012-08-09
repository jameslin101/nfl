require "nokogiri"
require "open-uri"

url = "http://sports.yahoo.com/nfl/players/5228/career"
doc = Nokogiri::HTML(open(url))
puts doc.at_css("title").text
puts doc.at_css(".player-name").text
puts doc.at_css(".uniform-number").text
puts doc.at_css(".position").text
puts doc.at_css(".team-name span").text
puts doc.at_css("time").text
puts doc.at_css(".college span").text
puts doc.at_css(".weight").text
puts doc.at_css(".height").text
#qb
doc_var = doc.at_css(":nth-child(3) .yspscores:nth-child(1)")
season = doc_var.text if doc_var

stat_find = "table:nth-child(5) :nth-child(%i) .yspscores:nth-child(%i)"
row = 3
while season do
  # css_string = "table:nth-child(5) :nth-child(" + row.to_s + ") .yspscores:nth-child(" + column.to_s + ")"
  
  season = stat_find % [row, 1]
  season[team   = stat_find % [row, 2]
  games  = stat_find % [row, 3]
  qbrat  = stat_find % [row, 1]
  comp   = stat_find % [row, 1]
  att    = stat_find % [row, 1]
  pct    = stat_find % [row, 1]
  season = stat_find % [row, 1]
  season = stat_find % [row, 1]
  season = stat_find % [row, 1]
  season = stat_find % [row, 1]
  css_string = "table:nth-child(5) :nth-child(%i) .yspscores:nth-child(%i)" % [row, column]

  doc_var = doc.at_css(css_string)
  if !doc_var.nil?
    stat = doc_var.text 
  else 
    stat = ""
  end
  puts stat
end
#  row ++
#end
  
# do 
# puts doc.at_css(":nth-child(14) .yspscores:nth-child(1)").text
