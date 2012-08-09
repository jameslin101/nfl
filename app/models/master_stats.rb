class MasterStats < Stat

  #Quarterback - Passing, Rushing, Sacks, Fumbles
  #Running back - Rushing, Receiving, Fumbles
  #Wide Reciever - Receiving, Kickoff Returns, Punt Returns, Fumbles
  #TE - Receiving, Rushing, Fumbles
  #DE - Tackles, Sacks, Interceptions, Misc
  #DT - Tackles, Sacks, Interceptions, Misc
  #NT - Tackles, Sacks, Interceptions, Misc
  #S - Tackles, Sacks, Interceptions, Misc
  #CB - Tackles, Sacks, Interceptions, Misc
  
  #Passing
  field :qb_rating, type: Float
  field :comps, type: Integer
  field :atts, type: Integer
  field :pct, type: Float
  field :passing_yards, type: Integer
  field :passing_yards_per_game, type: Float
  field :yards_per_pass, type: Float
  field :passing_tds, type: Integer
  field :ints, type: Integer

  #Rushing
  field :rushes, type: Float
  field :rushing_yards, type: Integer
  field :rushing_yards_per_game, type: Float
  field :yards_per_rush, type: Float
  field :rushing_tds, type: Integer
  
  #Receiving
  field :recs, type: Integer
  field :receiving_yards, type: Integer
  field :receiving_yards_per_game, type: Float
  field :yards_per_reception, type: Float
  field :long, type: Integer
  field :yac, type: Float
  field :first_downs, type: Integer
  field :receiving_tds, type: Integer
  
  #Fumbles
  field :fumbles, type: Integer
  field :fumbles_lost, type: Integer
  
  #Sacks
  field :sacks, type: Float
  field :sacks_yards_lost, type: Integer
  
  #Kickoff Returns
  field :kr, type: Integer
  field :kr_yards, type: Integer
  field :yards_per_kr, Float
  field :kr_long, type: Integer
  field :kr_tds, type: Integer
  
  #Punt Returns
  field :pr, type: Integer
  field :pr_yards, type: Integer
  field :yards_per_pr, Float
  field :pr_long, type: Integer
  field :pr_tds, type: Integer
  
  #Tackles
  field :tackles_solo, type: Integer
  field :tackles_ast, type: Integer
  field :tackles_total, type: Integer
  
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
