class DpStat < Stat
  
  embedded_in :dp
  #Defensive Player - Tackles, Sacks, Interceptions, Misc
  
  #Tackles
  field :tackles_solo,      type: Integer
  field :tackles_ast,       type: Integer
  field :tackles_total,     type: Integer
  
  #Sacks
  field :sacks,             type: Float
  field :sacks_yards_lost,  type: Integer
  
  #Interceptions
  field :int,               type: Integer
  field :int_yards,         type: Integer
  field :int_tds,           type: Integer
  
  #Misc
  field :def_td,            type: Integer
  field :forced_fumbles,    type: Integer
  field :passes_defended,   type: Integer
  field :safeties,          type: Integer
  
  def stat_display_order
    [ :season,
      :team,
      :games,
      
      :tackles_solo,   
      :tackles_ast,    
      :tackles_total,
      
      :sacks,          
      :sacks_yards_lost,
      
      :int,            
      :int_yards,      
      :int_tds,        
      
      :def_td,         
      :forced_fumbles, 
      :passes_defended,
      :safeties]   
  end
end
   