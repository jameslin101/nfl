require "open-uri"
require "hpricot"

task :seed_players  => [:environment] do seed_players   end
task :seed_season      => [:environment] do seed_season       end
task :seed_week      => [:environment] do seed_week       end
task :seed_gametimes      => [:environment] do seed_gametimes        end

YAHOO_OFFENSE_SEASON_FOOTBALL_URL = "http://football.fantasysports.yahoo.com/f1/560932/players?status=ALL&pos=O&cut_type=9&stat1=S_S_***&myteam=0&sort=AR&sdir=1&count=###"
YAHOO_KICKER_SEASON_FOOTBALL_URL = "http://football.fantasysports.yahoo.com/f1/560932/players?status=ALL&pos=K&cut_type=9&stat1=S_S_***&myteam=0&sort=AR&sdir=1&count=###"
YAHOO_DEFENSE_SEASON_FOOTBALL_URL = "http://football.fantasysports.yahoo.com/f1/560932/players?status=ALL&pos=DEF&cut_type=9&stat1=S_S_***&myteam=0&sort=AR&sdir=1&count=###"

YAHOO_OFFENSE_WEEK_FOOTBALL_URL = "http://football.fantasysports.yahoo.com/f1/560932/players?&sort=AR&sdir=1&status=ALL&pos=O&stat1=S_W_***&count=###"
YAHOO_KICKER_WEEK_FOOTBALL_URL = "http://football.fantasysports.yahoo.com/f1/560932/players?&sort=AR&sdir=1&status=ALL&pos=K&stat1=S_W_***&count=###"
YAHOO_DEFENSE_WEEK_FOOTBALL_URL = "http://football.fantasysports.yahoo.com/f1/560932/players?&sort=AR&sdir=1&status=ALL&pos=DEF&stat1=S_W_***&count=###"

YAHOO_SCOREBOARD_URL = "http://sports.yahoo.com/nfl/scoreboard?w="  

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

  
def clear_players 
  puts "Cleaning Database"

  NflPlayer.destroy_all

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

def parse_football_player_list(player_type, url, week)
  year = 2011
  #year = Time.today.year
  agent = Mechanize.new
  rank_count = 0

  200.times do |n|
    count = 0
    url_with_count = url.gsub("###","#{n*25}")
    
    if (week !=0 )
    url_with_count = url_with_count.gsub("***","#{week}")
    else
    url_with_count = url_with_count.gsub("***","#{year}")  
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
      
      
      player.season = year 
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
  
def seed_gametimes
  
  current_week = DateHelper::get_week
  game_day = []
  
  #Create HashMap Lookup for Team Short Name to Player Team 
  yahoo_team = {}
  
  yahoo_team['dal']='DAL'
  yahoo_team['nyg']='NYG'
  yahoo_team['nwe']='NE'
  yahoo_team['ten']='TEN'
  yahoo_team['mia']='MIA'
  yahoo_team['hou']='HOU'
  yahoo_team['buf']='BUF'
  yahoo_team['nyj']='NYJ'
  yahoo_team['atl']='ATL'
  yahoo_team['kan']='KC'
  yahoo_team['jac']='JAC'
  yahoo_team['min']='MIN'
  yahoo_team['phi']='PHI'
  yahoo_team['cle']='CLE'
  yahoo_team['ind']='IND'
  yahoo_team['chi']='CHI'
  yahoo_team['was']='WAS'
  yahoo_team['nor']='NO'
  yahoo_team['stl']='STL'
  yahoo_team['det']='DET'
  yahoo_team['car']='CAR'
  yahoo_team['tam']='TB'
  yahoo_team['sea']='SEA'
  yahoo_team['ari']='ARI'
  yahoo_team['sfo']='SF'
  yahoo_team['gnb']='GB'
  yahoo_team['pit']='PIT'
  yahoo_team['den']='DEN'
  yahoo_team['cin']='CIN'
  yahoo_team['bal']='BAL'
  yahoo_team['sdg']='SD'
  yahoo_team['oak']='OAK'
    
  puts Time.now.to_s
  puts YAHOO_SCOREBOARD_URL+current_week.to_s
  agent = Mechanize.new
  page = agent.get(YAHOO_SCOREBOARD_URL+current_week.to_s)  
  doc = Hpricot(page.parser.to_s)    
    
  doc.search("a[@class=tickets yspmore]").each do |item|
    date_string = item[:href].split('date=').last+' -04:00'
      
    game_day.push(DateTime.parse(date_string))
  end
  
  count = 0
  array_count = 0
  time_string = ''
  doc.search("tr[@class=ysptblclbg5]").each do |item|
    team_name = item.search("a").first[:href].split('teams/').last
    
    if (count%2 == 0)
      time_string = item.search("span[@class=yspscores]").first.innerHTML.strip
    end
    game_date = game_day[array_count]
    
    time_split = time_string.split(' ')
    hour = time_split.first.split(':').first.to_i + 12
    min = time_split.first.split(':').last.to_i
    
    game_time = DateTime.new(game_date.year,game_date.mon,game_date.mday,hour,min,0,'-4')
    
    #Update game time for NflPlayers for every team on scoreboard
    #Teams with BYE opponent will not have time updated
    #puts yahoo_team[team_name] + '-' + game_time.to_s
    puts "Updating Team Gametime - #{yahoo_team[team_name]}"
    players = NflPlayer.where(team: yahoo_team[team_name])
    players.each do |player| 
      player.game_time = game_time
      player.save
    end
    count += 1     
    if (count%2 == 0)
      array_count+=1
    end
    
    #puts item    
  end
  
end
