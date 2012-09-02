require "open-uri"
require "hpricot"

task :seed_players  => [:environment] do seed_players   end
task :seed_qbs      => [:environment] do seed_qbs       end
task :seed_rbs      => [:environment] do seed_rbs       end
task :seed_wrs      => [:environment] do seed_wrs       end
task :seed_tes      => [:environment] do seed_tes       end
task :seed_des      => [:environment] do seed_des       end
task :seed_dts      => [:environment] do seed_dts       end
task :seed_nts      => [:environment] do seed_nts       end
task :seed_lbs      => [:environment] do seed_lbs       end
task :seed_safeties => [:environment] do seed_safeties  end
task :seed_cbs      => [:environment] do seed_cbs       end
task :seed_kickers  => [:environment] do seed_kickers   end
#task :seed_punters  => [:environment] do seed_punters   end
task :seed_season      => [:environment] do seed_season       end
task :seed_week      => [:environment] do seed_week       end

YAHOO_OFFENSE_SEASON_FOOTBALL_URL = "http://football.fantasysports.yahoo.com/f1/560932/players?status=ALL&pos=O&cut_type=9&stat1=S_S_***&myteam=0&sort=AR&sdir=1&count=###"
YAHOO_KICKER_SEASON_FOOTBALL_URL = "http://football.fantasysports.yahoo.com/f1/560932/players?status=ALL&pos=K&cut_type=9&stat1=S_S_***&myteam=0&sort=AR&sdir=1&count=###"
YAHOO_DEFENSE_SEASON_FOOTBALL_URL = "http://football.fantasysports.yahoo.com/f1/560932/players?status=ALL&pos=DEF&cut_type=9&stat1=S_S_***&myteam=0&sort=AR&sdir=1&count=###"

YAHOO_OFFENSE_WEEK_FOOTBALL_URL = "http://football.fantasysports.yahoo.com/f1/560932/players?&sort=AR&sdir=1&status=ALL&pos=O&stat1=S_W_***&count=###"
YAHOO_KICKER_WEEK_FOOTBALL_URL = "http://football.fantasysports.yahoo.com/f1/560932/players?&sort=AR&sdir=1&status=ALL&pos=K&stat1=S_W_***&count=###"
YAHOO_DEFENSE_WEEK_FOOTBALL_URL = "http://football.fantasysports.yahoo.com/f1/560932/players?&sort=AR&sdir=1&status=ALL&pos=DEF&stat1=S_W_***&count=###"

YAHOO_LOGIN_URL = "https://login.yahoo.com/config/login" 

def seed_players
   parse_football_player_list('PLAYER',YAHOO_KICKER_SEASON_FOOTBALL_URL, 0)
   parse_football_player_list('PLAYER',YAHOO_DEFENSE_SEASON_FOOTBALL_URL, 0)
   parse_football_player_list('PLAYER',YAHOO_OFFENSE_SEASON_FOOTBALL_URL, 0)
end



def seed_season
  parse_football_player_list('OFF',YAHOO_OFFENSE_SEASON_FOOTBALL_URL, 0)
  parse_football_player_list('DEF',YAHOO_DEFENSE_SEASON_FOOTBALL_URL, 0)
  parse_football_player_list('KICK',YAHOO_KICKER_SEASON_FOOTBALL_URL, 0)
end

def seed_week
  current_week = DateHelper::get_week
  prior_week = current_week - 1
  parse_football_player_list('OFF',YAHOO_OFFENSE_WEEK_FOOTBALL_URL, prior_week)  
  parse_football_player_list('KICK',YAHOO_KICKER_WEEK_FOOTBALL_URL, prior_week)
  parse_football_player_list('DEF',YAHOO_DEFENSE_WEEK_FOOTBALL_URL, prior_week)
end

def seed_qbs
  pos = "http://sports.yahoo.com/nfl/players?type=position&c=NFL&pos=QB"
  get_links(pos).each_with_index do |yahoo_id, i| 
    wait(i)    
    make_qb(yahoo_id)
  end
end

def seed_rbs
  pos = "http://sports.yahoo.com/nfl/players?type=position&c=NFL&pos=RB"
  get_links(pos).each_with_index do |yahoo_id, i| 
    wait(i)    
    make_rb(yahoo_id)
  end  
end

def seed_wrs
  pos = "http://sports.yahoo.com/nfl/players?type=position&c=NFL&pos=WR"
  get_links(pos).each_with_index do |yahoo_id, i| 
    wait(i)    
    make_wr(yahoo_id)
  end
end

def seed_tes 
  pos = "http://sports.yahoo.com/nfl/players?type=position&c=NFL&pos=TE"
  get_links(pos).each_with_index do |yahoo_id, i| 
    wait(i)    
    make_te(yahoo_id)
  end
end

def seed_des
  pos = "http://sports.yahoo.com/nfl/players?type=position&c=NFL&pos=DE"
  get_links(pos).each_with_index do |yahoo_id, i| 
    wait(i)    
    make_dp(yahoo_id)
  end
end

def seed_dts
  pos = "http://sports.yahoo.com/nfl/players?type=position&c=NFL&pos=DT"
  get_links(pos).each_with_index do |yahoo_id, i| 
    wait(i)    
    make_dp(yahoo_id)
  end
end

def seed_nts 
  pos = "http://sports.yahoo.com/nfl/players?type=position&c=NFL&pos=NT"
  get_links(pos).each_with_index do |yahoo_id, i| 
    wait(i)    
    make_dp(yahoo_id)
  end
end

def seed_lbs
  pos = "http://sports.yahoo.com/nfl/players?type=position&c=NFL&pos=LB"
  get_links(pos).each_with_index do |yahoo_id, i| 
    wait(i)    
    make_dp(yahoo_id)
  end
end

def seed_safeties 
  pos = "http://sports.yahoo.com/nfl/players?type=position&c=NFL&pos=S"
  get_links(pos).each_with_index do |yahoo_id, i| 
    wait(i)    
    make_dp(yahoo_id)
  end
end

def seed_cbs 
  pos = "http://sports.yahoo.com/nfl/players?type=position&c=NFL&pos=CB"
  get_links(pos).each_with_index do |yahoo_id, i| 
    wait(i)    
    make_dp(yahoo_id)
  end
end

def seed_kickers 
  pos = "http://sports.yahoo.com/nfl/players?type=position&c=NFL&pos=K"
  get_links(pos).each_with_index do |yahoo_id, i| 
    wait(i)    
    make_kicker(yahoo_id)
  end
end

def seed_punters 
  pos = "http://sports.yahoo.com/nfl/players?type=position&c=NFL&pos=P"
  get_links(pos).each_with_index do |yahoo_id, i| 
    wait(i)    
    make_punter(yahoo_id)
  end
end
  
def clear_players 
  puts "Cleaning Database"

  NflPlayer.destroy_all

end

def make_qb(yahoo_id)
  puts "Making QB: "+yahoo_id
  doc = Nokogiri::HTML(open(get_url(yahoo_id)))
  qb = Qb.find_or_create_by(yahoo_id: yahoo_id)
  get_player_bio(qb, doc)
  
  row = 3
  season = get_stat(doc, row, 1, "String")
  season = season.slice(1..8) if season
         
  while season do
    qb_stat = qb.qb_stats.find_or_create_by(season: season)

    #correct for yahoo "Career" column
    if season == "Career" 
      c = -1 
    else
      c = 0
      qb_stat.team                      = get_stat(doc, row, c+2, "String")
    end

    qb_stat.games                   = get_stat(doc, row, c+3, "Integer")
                                   
    qb_stat.qb_rating               = get_stat(doc, row, c+5, "Float")
    qb_stat.comps                   = get_stat(doc, row, c+6, "Integer")
    qb_stat.atts                    = get_stat(doc, row, c+7, "Integer")
    qb_stat.pct                     = get_stat(doc, row, c+8, "Float")
    qb_stat.passing_yards           = get_stat(doc, row, c+9, "Integer")
    qb_stat.passing_yards_per_game  = get_stat(doc, row, c+10, "Float")
    qb_stat.yards_per_pass          = get_stat(doc, row, c+11, "Float")
    qb_stat.passing_tds             = get_stat(doc, row, c+12, "Integer")
    qb_stat.ints                    = get_stat(doc, row, c+13, "Integer")
    
    qb_stat.rushes                  = get_stat(doc, row, c+15, "Float")
    qb_stat.rushing_yards           = get_stat(doc, row, c+16, "Integer")
    qb_stat.rushing_yards_per_game  = get_stat(doc, row, c+17, "Float")
    qb_stat.yards_per_rush          = get_stat(doc, row, c+18, "Float")
    qb_stat.rushing_tds             = get_stat(doc, row, c+19, "Integer")
    
    qb_stat.sacks                   = get_stat(doc, row, c+21, "Integer")
    qb_stat.sacks_yards_lost        = get_stat(doc, row, c+22, "Integer")
    
    qb_stat.fumbles                 = get_stat(doc, row, c+24, "Integer")
    qb_stat.fumbles_lost            = get_stat(doc, row, c+25, "Integer")
    
    qb_stat.save
    
    row += 1 
    season = get_stat(doc, row, 1, "String")
    season = season.slice(1..8) if season
  
  end
  
end

def make_rb(yahoo_id)
  
  puts "Making RB: "+ yahoo_id

  doc = Nokogiri::HTML(open(get_url(yahoo_id)))
  rb = Rb.find_or_create_by(yahoo_id: yahoo_id)
  get_player_bio(rb, doc)
  
  row = 3
  season = get_stat(doc, row, 1, "String")
  season = season.slice(1..8) if season
         
  while season do
    rb_stat = rb.rb_stats.find_or_create_by(season: season)

    #correct for yahoo "Career" column
    if season == "Career" 
      c = -1 
    else
      c = 0
      rb_stat.team                      = get_stat(doc, row, c+2, "String")
    end

    rb_stat.games                     = get_stat(doc, row, c+3, "Integer")

    rb_stat.rushes                    = get_stat(doc, row, c+5, "Float")
    rb_stat.rushing_yards             = get_stat(doc, row, c+6, "Integer")
    rb_stat.rushing_yards_per_game    = get_stat(doc, row, c+7, "Float")
    rb_stat.yards_per_rush            = get_stat(doc, row, c+8, "Float")
    rb_stat.rushing_tds               = get_stat(doc, row, c+9, "Integer")
                                    
    rb_stat.recs                      = get_stat(doc, row, c+11, "Integer")
    rb_stat.receiving_yards           = get_stat(doc, row, c+12, "Integer")
    rb_stat.receiving_yards_per_game  = get_stat(doc, row, c+13, "Float")
    rb_stat.yards_per_reception       = get_stat(doc, row, c+14, "Float")
    rb_stat.long                      = get_stat(doc, row, c+15, "Integer")
    rb_stat.yac                       = get_stat(doc, row, c+16, "Float")
    rb_stat.first_downs               = get_stat(doc, row, c+17, "Integer")
    rb_stat.receiving_tds             = get_stat(doc, row, c+18, "Integer")
    
    rb_stat.fumbles                   = get_stat(doc, row, c+20, "Integer")
    rb_stat.fumbles_lost              = get_stat(doc, row, c+21, "Integer")
    
    rb_stat.save
    
    row += 1 
    season = get_stat(doc, row, 1, "String")
    season = season.slice(1..8) if season
  
  end
  
end

def make_wr(yahoo_id)
  
  puts "Making WR: "+yahoo_id
  
  doc = Nokogiri::HTML(open(get_url(yahoo_id)))
  wr = Wr.find_or_create_by(yahoo_id: yahoo_id)
  get_player_bio(wr, doc)
  
  row = 3
  season = get_stat(doc, row, 1, "String")
  season = season.slice(1..8) if season
         
  while season do
    wr_stat = wr.wr_stats.find_or_create_by(season: season)

    #correct for yahoo "Career" column
    if season == "Career" 
      c = -1 
    else
      c = 0
      wr_stat.team                    = get_stat(doc, row, c+2, "String")
    end

    wr_stat.games                     = get_stat(doc, row, c+3, "Integer")
                                    
    wr_stat.recs                      = get_stat(doc, row, c+5, "Integer")
    wr_stat.receiving_yards           = get_stat(doc, row, c+6, "Integer")
    wr_stat.receiving_yards_per_game  = get_stat(doc, row, c+7, "Float")
    wr_stat.yards_per_reception       = get_stat(doc, row, c+8, "Float")
    wr_stat.long                      = get_stat(doc, row, c+9, "Integer")
    wr_stat.yac                       = get_stat(doc, row, c+10, "Float")
    wr_stat.first_downs               = get_stat(doc, row, c+11, "Integer")
    wr_stat.receiving_tds             = get_stat(doc, row, c+12, "Integer")

    wr_stat.kr                        = get_stat(doc, row, c+14, "Integer")
    wr_stat.kr_yards                  = get_stat(doc, row, c+15, "Integer")
    wr_stat.yards_per_kr              = get_stat(doc, row, c+16, "Float")
    wr_stat.kr_long                   = get_stat(doc, row, c+17, "Integer")
    wr_stat.kr_tds                    = get_stat(doc, row, c+18, "Integer")

    wr_stat.pr                        = get_stat(doc, row, c+20, "Integer")           
    wr_stat.pr_yards                  = get_stat(doc, row, c+21, "Integer")
    wr_stat.yards_per_pr              = get_stat(doc, row, c+22, "Float")
    wr_stat.pr_long                   = get_stat(doc, row, c+23, "Integer")
    wr_stat.pr_tds                    = get_stat(doc, row, c+24, "Integer")
    
    wr_stat.fumbles                   = get_stat(doc, row, c+26, "Integer")
    wr_stat.fumbles_lost              = get_stat(doc, row, c+27, "Integer")
    
    wr_stat.save
    
    row += 1 
    season = get_stat(doc, row, 1, "String")
    season = season.slice(1..8) if season
  
  end
  
end

def make_te(yahoo_id)
  
  puts "Making TE: "+yahoo_id
  
  doc = Nokogiri::HTML(open(get_url(yahoo_id)))
  te = Te.find_or_create_by(yahoo_id: yahoo_id)
  get_player_bio(te, doc)
  
  row = 3
  season = get_stat(doc, row, 1, "String")
  season = season.slice(1..8) if season
         
  while season do
    te_stat = te.te_stats.find_or_create_by(season: season)

    #correct for yahoo "Career" column
    if season == "Career" 
      c = -1 
    else
      c = 0
      te_stat.team                    = get_stat(doc, row, c+2, "String")
    end

    te_stat.games                     = get_stat(doc, row, c+3, "Integer")
                                    
    te_stat.recs                      = get_stat(doc, row, c+5, "Integer")
    te_stat.receiving_yards           = get_stat(doc, row, c+6, "Integer")
    te_stat.receiving_yards_per_game  = get_stat(doc, row, c+7, "Float")
    te_stat.yards_per_reception       = get_stat(doc, row, c+8, "Float")
    te_stat.long                      = get_stat(doc, row, c+9, "Integer")
    te_stat.yac                       = get_stat(doc, row, c+10, "Float")
    te_stat.first_downs               = get_stat(doc, row, c+11, "Integer")
    te_stat.receiving_tds             = get_stat(doc, row, c+12, "Integer")

    te_stat.rushes                    = get_stat(doc, row, c+14, "Float")
    te_stat.rushing_yards             = get_stat(doc, row, c+15, "Integer")
    te_stat.rushing_yards_per_game    = get_stat(doc, row, c+16, "Float")
    te_stat.yards_per_rush            = get_stat(doc, row, c+17, "Float")
    te_stat.rushing_tds               = get_stat(doc, row, c+18, "Integer")
    
    te_stat.fumbles                   = get_stat(doc, row, c+20, "Integer")
    te_stat.fumbles_lost              = get_stat(doc, row, c+21, "Integer")
    
    te_stat.save
    
    row += 1 
    season = get_stat(doc, row, 1, "String")
    season = season.slice(1..8) if season
  
  end
  
end



def make_dp(yahoo_id)
  
  puts "Making Defensive Player: "+yahoo_id
  
  doc = Nokogiri::HTML(open(get_url(yahoo_id)))
  dp = Dp.find_or_create_by(yahoo_id: yahoo_id)
  get_player_bio(dp, doc)
  
  row = 3
  season = get_stat(doc, row, 1, "String")
  season = season.slice(1..8) if season
         
  while season do
    dp_stat = dp.dp_stats.find_or_create_by(season: season)

    #correct for yahoo "Career" column
    if season == "Career" 
      c = -1 
    else
      c = 0
      dp_stat.team                  = get_stat(doc, row, c+2, "String")
    end

    dp_stat.games                   = get_stat(doc, row, c+3, "Integer")
                                       
    dp_stat.tackles_solo            = get_stat(doc, row, c+5, "Integer")
    dp_stat.tackles_ast             = get_stat(doc, row, c+6, "Integer")
    dp_stat.tackles_total           = get_stat(doc, row, c+7, "Integer")
    
    dp_stat.sacks                   = get_stat(doc, row, c+9, "Integer")
    dp_stat.sacks_yards_lost        = get_stat(doc, row, c+10, "Integer")
    
    dp_stat.int                     = get_stat(doc, row, c+12, "Integer")
    dp_stat.int_yards               = get_stat(doc, row, c+13, "Integer")
    dp_stat.int_tds                 = get_stat(doc, row, c+14, "Integer")

    dp_stat.def_td                  = get_stat(doc, row, c+16, "Integer")
    dp_stat.forced_fumbles          = get_stat(doc, row, c+17, "Integer")
    dp_stat.passes_defended         = get_stat(doc, row, c+18, "Integer")
    dp_stat.safeties                = get_stat(doc, row, c+19, "Integer")
    
    dp_stat.save
    
    row += 1 
    season = get_stat(doc, row, 1, "String")
    season = season.slice(1..8) if season
  
  end
  
end

def make_kicker(yahoo_id)
  
  puts "Making Kicker: "+yahoo_id
  
  doc = Nokogiri::HTML(open(get_url(yahoo_id)))
  kicker = Kicker.find_or_create_by(yahoo_id: yahoo_id)
  get_player_bio(kicker, doc)
  
  row = 3
  season = get_stat(doc, row, 1, "String")
  season = season.slice(1..8) if season
         
  while season do
    kicker_stat = kicker.kicker_stats.find_or_create_by(season: season)

    #correct for yahoo "Career" column
    if season == "Career" 
      c = -1 
    else
      c = 0
      kicker_stat.team        = get_stat(doc, row, c+2, "String")
    end

    kicker_stat.games         = get_stat(doc, row, c+3, "Integer")
                                       
    kicker_stat.dist_0_19     = get_stat(doc, row, c+5, "String")
    kicker_stat.dist_19_29    = get_stat(doc, row, c+6, "String")
    kicker_stat.dist_30_39    = get_stat(doc, row, c+7, "String")
    kicker_stat.dist_40_49    = get_stat(doc, row, c+9, "String")
    kicker_stat.dist_50_plus  = get_stat(doc, row, c+10, "String")
    kicker_stat.fgm           = get_stat(doc, row, c+12, "Integer")
    kicker_stat.fga           = get_stat(doc, row, c+13, "Integer")
    kicker_stat.fg_pct        = get_stat(doc, row, c+14, "Float")
    kicker_stat.fg_long       = get_stat(doc, row, c+15, "Integer")

    kicker_stat.xpm           = get_stat(doc, row, c+17, "Integer")
    kicker_stat.xpa           = get_stat(doc, row, c+18, "Integer")
    kicker_stat.pat_pct       = get_stat(doc, row, c+19, "Float")
    
    kicker_stat.points        = get_stat(doc, row, c+21, "Integer")

    kicker_stat.save    
    
    row += 1 
    season = get_stat(doc, row, 1, "String")
    season = season.slice(1..8) if season
  
  end
  
end

def make_punter(yahoo_id)
  
  puts "Making Punter: "+yahoo_id
  
  doc = Nokogiri::HTML(open(get_url(yahoo_id)))
  punter = Punter.find_or_create_by(yahoo_id: yahoo_id)
  get_player_bio(punter, doc)
  
  row = 3
  season = get_stat(doc, row, 1, "String")
  season = season.slice(1..8) if season
         
  while season do
    punter_stat = punter.punter_stats.find_or_create_by(season: season)

    #correct for yahoo "Career" column
    if season == "Career" 
      c = -1 
    else
      c = 0
      punter_stat.team        = get_stat(doc, row, c+2, "String")
    end

    punter_stat.games         = get_stat(doc, row, c+3, "Integer")
                                       
    punter_stat.punts         = get_stat(doc, row, c+5, "Integer")
    punter_stat.punt_yards    = get_stat(doc, row, c+6, "Integer")
    punter_stat.punt_avg      = get_stat(doc, row, c+7, "Float")
    punter_stat.punt_long     = get_stat(doc, row, c+8, "Integer")
    punter_stat.in_20         = get_stat(doc, row, c+9, "Integer")
    punter_stat.in_10         = get_stat(doc, row, c+10, "Integer")
    punter_stat.fc            = get_stat(doc, row, c+11, "Integer")
    punter_stat.tb            = get_stat(doc, row, c+12, "Integer")
    punter_stat.blk           = get_stat(doc, row, c+13, "Integer")

    punter_stat.save    
    
    row += 1 
    season = get_stat(doc, row, 1, "String")
    season = season.slice(1..8) if season
  
  end
  
end


def get_player_bio(player, doc)
  
  player.name = doc.at_css(".player-name").text
  player.number = doc.at_css(".uniform-number").text
  player.position = doc.at_css(".position").text
  player.team = doc.at_css(".team-name span").text
  player.age = age(doc.at_css("time").text)
  player.born = doc.at_css(".born").text.sub("Born: ","")
  player.college = doc.at_css(".college span").text
  player.weight = doc.at_css(".weight").text.sub("Weight: ","")
  player.height = doc.at_css(".height").text.sub("Height: ","")
  player.draft = doc.at_css(".draft").text.sub("Draft: ","")
  player.save

end


def age(dob)
  dob = dob.to_time
  now = Time.now.utc.to_date
  now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
end


def get_stat(doc, row, column, type)
  css_string = "table:nth-child(5) :nth-child(%i) .yspscores:nth-child(%i)" % [row, column]
  #puts css_string
  if doc.at_css(css_string).nil?
    stat = ""
  else
    stat = doc.at_css(css_string).text.strip
  end
  
  case type
    when "Float"
      stat = stat.to_f
    when "Integer"
      stat = stat.to_i
  end
  # puts "return from playerhelp:" + stat.to_s
  return stat
end


def get_url(yahoo_id)
  "http://sports.yahoo.com/nfl/players/" + yahoo_id.to_s + "/career"
end

def get_links(pos)
  posdoc = Nokogiri::HTML(open(pos))
  links = posdoc.css(".ysprow1 td:nth-child(1) a").collect { |link| link['href'][/\d+/]}
  links.concat(posdoc.css(".ysprow2 td:nth-child(1) a").collect { |link| link['href'][/\d+/]})
  puts links
  links
end

def wait(i)
  sleep 5 if i % 2 == 0
end

def parse_football_player_list(player_type, url,  week)
  today = Time.now
  agent = Mechanize.new
  rank_count = 0
  200.times do |n|
    count = 0
    url_with_count = url.gsub("###","#{n*25}")
    
    if (week !=0 )
    url_with_count = url_with_count.gsub("***","#{week}")
    else
    url_with_count = url_with_count.gsub("***","#{today.year}")  
    end
    
    
    puts url_with_count
    
    page = agent.get(url_with_count)
  
    doc = Hpricot(page.parser.to_s)

    
    tbody = (doc/"table.teamtable//tbody").first
    (tbody/"tr").each do |row|
      name_cell = (row/"td//a.name").first
      #Exit Loop if there is no name to get meaning a empty page
      return if name_cell.nil?
      
      #Exit Loop and Method if there are no stats to get for the player      
      return if (!(row/"td")[6].innerHTML.strip.to_s.index('-').nil? && player_type != 'PLAYER')
      

      
      rank_count += 1
      name = name_cell.innerHTML.strip
       
     
      player_url = name_cell[:href].strip
      
      
      #For Team Defense
      if (player_url.index('teams').nil?)     
        yahoo_id = player_url.scan(/http:\/\/sports.yahoo.com\/nfl\/players\/(\d+)/).flatten.compact.first.strip
      else
        yahoo_id = player_url.scan(/http:\/\/sports.yahoo.com\/nfl\/teams\/(\w+)/).flatten.compact.first.strip
      end
            

      detail_cell = (row/"td//div.detail//span").first
      detail_cell_scan = detail_cell.innerHTML.scan(/([a-zA-Z]+) - ([a-zA-Z0-9,]+)/).flatten
      team_short_name = detail_cell_scan[0].upcase.strip
      position = detail_cell_scan[1].upcase.strip
    
      
      
      player = NflPlayer.find_or_create_by(yahoo_id: yahoo_id)

      player.name = ActiveSupport::Inflector.transliterate(name)  
      player.position = position
      player.yahoo_id = yahoo_id
      player.team = team_short_name.upcase
      
      
      player.season = today.year 
      player.opp = (row/"td")[3].innerHTML
      
     
     if (player_type == 'OFF')
       if ((row/"td")[6].innerHTML.strip.to_s.index('-').nil?)
         
        stat = player.stats.find_or_create_by(week: week)
        stat.week = week
        stat.opp = (row/"td")[3].innerHTML
        stat.pass_yds = (row/"td")[8].innerHTML.to_i        
        stat.pass_td = (row/"td")[9].innerHTML.to_i
        stat.intercept = (row/"td")[10].innerHTML.to_i
        stat.rush_yds = (row/"td")[12].innerHTML.to_i
        stat.rush_td = (row/"td")[13].innerHTML.to_i
        stat.rec = (row/"td")[15].innerHTML.to_i
        stat.rec_yds = (row/"td")[16].innerHTML.to_i
        stat.rec_td = (row/"td")[17].innerHTML.to_i
        stat.ret_td = (row/"td")[19].innerHTML.to_i
        stat.two_point = (row/"td")[20].innerHTML.to_i
        stat.fumble = (row/"td")[21].innerHTML.to_i
        stat.save
       end
     end
     if (player_type == 'DEF')
       if ((row/"td")[6].innerHTML.strip.to_s.index('-').nil?)
         
        stat = player.stats.find_or_create_by(week: week)
        stat.week = week
        stat.opp = (row/"td")[3].innerHTML
        stat.pts_allow = (row/"td")[8].innerHTML.to_i        
        stat.sack = (row/"td")[9].innerHTML.to_i
        stat.safe = (row/"td")[10].innerHTML.to_i
        stat.def_int = (row/"td")[12].innerHTML.to_i
        stat.def_fumble = (row/"td")[13].innerHTML.to_i
        stat.def_td = (row/"td")[14].innerHTML.to_i
        stat.block_kick = (row/"td")[15].innerHTML.to_i
        stat.def_ret_td = (row/"td")[16].innerHTML.to_i
        
        
        stat.save
       end
     end
     if (player_type == 'KICK')
       if ((row/"td")[6].innerHTML.strip.to_s.index('-').nil?)
         
        stat = player.stats.find_or_create_by(week: week)
        stat.week = week
        stat.opp = (row/"td")[3].innerHTML
        stat.fg10 = (row/"td")[8].innerHTML.to_i        
        stat.fg20 = (row/"td")[9].innerHTML.to_i
        stat.fg30 = (row/"td")[10].innerHTML.to_i
        stat.fg40 = (row/"td")[11].innerHTML.to_i
        stat.fg50 = (row/"td")[12].innerHTML.to_i
        stat.pat = (row/"td")[15].innerHTML.to_i
        
        stat.save
       end
     end  
      
     puts player.name+"-"+player.position+"-"+player.yahoo_id
     player.save

      count = count + 1
    end
    return if count == 0

    sleep rand(10)
  end              
end
  
