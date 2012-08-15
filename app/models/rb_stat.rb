class RbStat < Stat
  
  embedded_in :rb
  
  #Running back - Rushing, Receiving, Fumbles 
  
  #Rushing
  field :rushes,                    type: Float
  field :rushing_yards,             type: Integer
  field :rushing_yards_per_game,    type: Float
  field :yards_per_rush,            type: Float
  field :rushing_tds,               type: Integer
  
  #Receiving
  field :recs,                      type: Integer
  field :receiving_yards,           type: Integer
  field :receiving_yards_per_game,  type: Float
  field :yards_per_reception,       type: Float
  field :long,                      type: Integer
  field :yac,                       type: Float
  field :first_downs,               type: Integer
  field :receiving_tds,             type: Integer
  
  #Fumbles
  field :fumbles,                   type: Integer
  field :fumbles_lost,              type: Integer

  def stat_display_order
  [ :season,
    :team,
    :games,
    
    :rushes,                  
    :rushing_yards,           
    :rushing_yards_per_game,  
    :yards_per_rush,          
    :rushing_tds,             
    
    :recs,                    
    :receiving_yards,         
    :receiving_yards_per_game,
    :yards_per_reception,     
    :long,                    
    :yac,                     
    :first_downs,             
    :receiving_tds,           
    
    :fumbles,                 
    :fumbles_lost]
  end
end    