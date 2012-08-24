module NflPlayersHelper
  
  POS_HASH = {"Quarterback" => "QB",
              "Running Back" => "RB",
              "Wide Receiver" => "WR",
              "Tight End" => "TE",
              "Kicker" => "K",
              "Defensive End" => "DL",
              "Defensive Tackle" => "DL",
              "Nose Tackle" => "DL",
              "Cornerback" => "CB",
              "Linebacker" => "LB",
              "Safety" => "S"}
  
  TEAM_HASH = { "Arizona Cardinals" => "Ari",
                "Atlanta Falcons" => "Atl",
                "Baltimore Ravens" => "Bal",
                "Buffalo Bills" => "Buf",
                "Carolina Panthers" => "Car",
                "Chicago Bears" =>  "Chi",
                "Cincinnati Bengals" => "Cin",
                "Cleveland Browns" =>  "Cle",
                "Dallas Cowboys" => "Dal",
                "Denver Broncos" => "Den",
                "Detroit Lions" => "Det",
                "Green Bay Packers" => "GB",
                "Houston Texans" => "Hou",
                "Indianapolis Colts" => "Ind",
                "Jacksonville Jaguars" => "Jac",
                "Kansas City Chiefs" => "KC",
                "Miami Dolphins" => "Mia",
                "Minnesota Vikings" => "Min",
                "New England Patriots" => "NE",
                "New Orleans Saints" => "NO",
                "New York Giants" => "NYG",
                "New York Jets" => "NYJ",
                "Oakland Raiders" => "Oak",
                "Philadelphia Eagles" => "Phi",
                "Pittsburgh Steelers" => "Pit",
                "San Diego Chargers" => "SD",
                "San Francisco 49ers" => "SF",
                "Seattle Seahawks" => "Sea",
                "St. Louis Rams" => "StL",
                "Tampa Bay Buccaneers" => "TB",
                "Tennessee Titans" => "Ten",
                "Washington Redskins" => "Was"}            
              
  
  def NflPlayersHelper::position_abbr(pos)

    if POS_HASH[pos]
      POS_HASH[pos]
    else
     "No Position Error"
    end
  end
    
  def NflPlayersHelper::team_abbr(team)
     
    if TEAM_HASH[team]
      TEAM_HASH[team]
    else 
      if TEAM_HASH.invert[team]
        TEAM_HASH.invert[team]      
      else
        "No Team Error"
      end
    end
  end
end
