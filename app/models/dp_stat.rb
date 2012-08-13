class DpStat < Stat
  
  #Defensive Player - Tackles, Sacks, Interceptions, Misc
  
  #Tackles
  field :tackles_solo, type: Integer
  field :tackles_ast, type: Integer
  field :tackles_total, type: Integer
  
  #Sacks
  field :sacks, type: Float
  field :sacks_yards_lost, type: Integer
  
  #Interceptions
  field :int, type: Integer
  field :int_yards, type: Integer
  field :int_tds, type: Integer
  
  #Misc
  field :def_td, type: Integer
  field :forced_fumbles, type: Integer
  field :passes_defended, type: Integer
  field :safeties, type: Integer
  
end