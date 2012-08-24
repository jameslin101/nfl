class QbStat < Stat

  embedded_in :qb
  #Quarterback - Passing, Rushing, Sacks, Fumbles

  #Passing
  field :qb_rating,               type: Float
  field :comps,                   type: Integer
  field :atts,                    type: Integer
  field :pct,                     type: Float
  field :passing_yards,           type: Integer
  field :passing_yards_per_game,  type: Float
  field :yards_per_pass,          type: Float
  field :passing_tds,             type: Integer
  field :ints,                    type: Integer
  
  #Rushing
  field :rushes,                  type: Float
  field :rushing_yards,           type: Integer
  field :rushing_yards_per_game,  type: Float
  field :yards_per_rush,          type: Float
  field :rushing_tds,             type: Integer
  
  #Sacks
  field :sacks,                   type: Float
  field :sacks_yards_lost,        type: Integer
  
  #Fumbles
  field :fumbles,                 type: Integer
  field :fumbles_lost,            type: Integer


  def stat_display_order
  [ :season,
    :team,
    :games,
    
    :qb_rating,             
    :comps,                 
    :atts,                  
    :pct,                   
    :passing_yards,         
    :passing_yards_per_game,
    :yards_per_pass,        
    :passing_tds,           
    :ints,                  
    
    :rushes,                
    :rushing_yards,         
    :rushing_yards_per_game,
    :yards_per_rush,        
    :rushing_tds,           
    
    :sacks,                 
    :sacks_yards_lost,      
    
    :fumbles,               
    :fumbles_lost]
  end
  
end  