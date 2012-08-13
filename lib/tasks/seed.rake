task :seed_qb => [:environment, :clear_qbs] do
  puts "hello"
  
  #require "player_helper"
  #require "nokogiri"
  require "open-uri"
  
  url = "http://sports.yahoo.com/nfl/players/5228/career"

  make_qb(url)
    # doc_var = doc.at_css(css_string)
    # if !doc_var.nil?
    #   stat = doc_var.text 
    # else 
    #   stat = ""
    # end
    # puts stat
  


  # do 
  # puts doc.at_css(":nth-child(14) .yspscores:nth-child(1)").text
  
end


task :clear_qbs => [:environment] do
  puts "Deleting all Qbs"

  Qb.delete_all

end

def make_qb(url)
  
  doc = Nokogiri::HTML(open(url))
  
  qb = Qb.new
  
  doc.at_css("title").text
  qb.name = doc.at_css(".player-name").text
  qb.number = doc.at_css(".uniform-number").text
  qb.position = doc.at_css(".position").text
  qb.team = doc.at_css(".team-name span").text
  qb.age = PlayerHelper::age(doc.at_css("time").text)
  qb.born = doc.at_css(".born").text.sub("Born: ","")
  qb.college = doc.at_css(".college span").text
  qb.weight = doc.at_css(".weight").text.sub("Weight: ","")
  qb.height = doc.at_css(".height").text.sub("Height: ","")
  qb.draft = doc.at_css(".draft").text.sub("Draft: ","")
  qb.save
  #qb
  #doc_var = doc.at_css(":nth-child(3) .yspscores:nth-child(1)")
  #season = doc_var.text if doc_var
  
  #stat_find = "table:nth-child(5) :nth-child(%i) .yspscores:nth-child(%i)"
  
  
  row = 3
  season = PlayerHelper::get_stat(doc, row, 1, "String")
  season = season.slice(1..8) if season
  
  while season do
    qb_stat = qb.qb_stats.find_or_create_by(season: season)
  
    qb_stat.team   = PlayerHelper::get_stat(doc, row, 2, "String")
    qb_stat.games  = PlayerHelper::get_stat(doc, row, 3, "Integer")
  
    qb_stat.qb_rating              = PlayerHelper::get_stat(doc, row, 5, "Float")
    qb_stat.comps                  = PlayerHelper::get_stat(doc, row, 6, "Integer")
    qb_stat.atts                   = PlayerHelper::get_stat(doc, row, 7, "Integer")
    qb_stat.pct                    = PlayerHelper::get_stat(doc, row, 8, "Float")
    qb_stat.passing_yards          = PlayerHelper::get_stat(doc, row, 9, "Integer")
    qb_stat.passing_yards_per_game = PlayerHelper::get_stat(doc, row, 10, "Float")
    qb_stat.yards_per_pass         = PlayerHelper::get_stat(doc, row, 11, "Float")
    qb_stat.passing_tds            = PlayerHelper::get_stat(doc, row, 12, "Integer")
    qb_stat.ints                   = PlayerHelper::get_stat(doc, row, 13, "Integer")
    
    # qb_stat.rushing                = PlayerHelper::get_stat(row, 13, "Integer")
    # qb_stat.rushing
    # 
    qb_stat.save
    
    row += 1 
    season = PlayerHelper::get_stat(doc, row, 1, "String")
    season = season.slice(1..8) if season
  
  end
end

def make_qb_url(url)
  
  doc = Nokogiri::HTML(open(url))
  
  qb = Qb.new
  
  doc.at_css("title").text
  qb.name = doc.at_css(".player-name").text
  qb.number = doc.at_css(".uniform-number").text
  qb.position = doc.at_css(".position").text
  qb.team = doc.at_css(".team-name span").text
  qb.age = PlayerHelper::age(doc.at_css("time").text)
  qb.born = doc.at_css(".born").text.sub("Born: ","")
  qb.college = doc.at_css(".college span").text
  qb.weight = doc.at_css(".weight").text.sub("Weight: ","")
  qb.height = doc.at_css(".height").text.sub("Height: ","")
  qb.draft = doc.at_css(".draft").text.sub("Draft: ","")
  qb.save
  #qb
  #doc_var = doc.at_css(":nth-child(3) .yspscores:nth-child(1)")
  #season = doc_var.text if doc_var
  
  #stat_find = "table:nth-child(5) :nth-child(%i) .yspscores:nth-child(%i)"
  
  
  row = 3
  season = PlayerHelper::get_stat(doc, row, 1, "String")
  season = season.slice(1..8) if season
  
  while season do
    qb_stat = qb.qb_stats.find_or_create_by(season: season)
  
    qb_stat.team   = PlayerHelper::get_stat(doc, row, 2, "String")
    qb_stat.games  = PlayerHelper::get_stat(doc, row, 3, "Integer")
  
    qb_stat.qb_rating              = PlayerHelper::get_stat(doc, row, 5, "Float")
    qb_stat.comps                  = PlayerHelper::get_stat(doc, row, 6, "Integer")
    qb_stat.atts                   = PlayerHelper::get_stat(doc, row, 7, "Integer")
    qb_stat.pct                    = PlayerHelper::get_stat(doc, row, 8, "Float")
    qb_stat.passing_yards          = PlayerHelper::get_stat(doc, row, 9, "Integer")
    qb_stat.passing_yards_per_game = PlayerHelper::get_stat(doc, row, 10, "Float")
    qb_stat.yards_per_pass         = PlayerHelper::get_stat(doc, row, 11, "Float")
    qb_stat.passing_tds            = PlayerHelper::get_stat(doc, row, 12, "Integer")
    qb_stat.ints                   = PlayerHelper::get_stat(doc, row, 13, "Integer")
    
    # qb_stat.rushing                = PlayerHelper::get_stat(row, 13, "Integer")
    # qb_stat.rushing
    # 
    qb_stat.save
    
    row += 1 
    season = PlayerHelper::get_stat(doc, row, 1, "String")
    season = season.slice(1..8) if season
  
  end
end