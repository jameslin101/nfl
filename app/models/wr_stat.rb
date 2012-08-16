class WrStat < Stat
  
  embedded_in :wr
  
  #Wide Reciever - Receiving, Kickoff Returns, Punt Returns, Fumbles
  
  #Receiving
  field :recs,                      type: Integer
  field :receiving_yards,           type: Integer
  field :receiving_yards_per_game,  type: Float
  field :yards_per_reception,       type: Float
  field :long,                      type: Integer
  field :yac,                       type: Float
  field :first_downs,               type: Integer
  field :receiving_tds,             type: Integer
  
  #Kickoff Returns
  field :kr,                        type: Integer
  field :kr_yards,                  type: Integer
  field :yards_per_kr,              type: Float
  field :kr_long,                   type: Integer
  field :kr_tds,                    type: Integer
  
  #Punt Returns
  field :pr,                        type: Integer
  field :pr_yards,                  type: Integer
  field :yards_per_pr,              type: Float
  field :pr_long,                   type: Integer
  field :pr_tds,                    type: Integer
  
  #Fumbles
  field :fumbles,                   type: Integer
  field :fumbles_lost,              type: Integer

  def stat_display_order
  [ :season,
    :team,
    :games,
    
    :recs,                   
    :receiving_yards,        
    :receiving_yards_per_game,
    :yards_per_reception,    
    :long,                   
    :yac,                    
    :first_downs,            
    :receiving_tds,          
    
    :kr,                     
    :kr_yards,               
    :yards_per_kr,           
    :kr_long,                
    :kr_tds,                 
    
    :pr,                     
    :pr_yards,               
    :yards_per_pr,           
    :pr_long,                
    :pr_tds,                 
    
    :fumbles,                
    :fumbles_lost]
  end
end        