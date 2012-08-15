class PunterStat < Stat

  embedded_in :punter
  
  #Punting
  field :punts,       type: Integer
  field :punt_yards,  type: Integer
  field :punt_avg,    type: Float
  field :punt_long,   type: Integer
  field :in_20,       type: Integer
  field :in_10,       type: Integer
  field :fc,          type: Integer
  field :tb,          type: Integer
  field :blk,         type: Integer

  def stat_display_order
    [ :season,
      :team,
      :games,
      :punts,      
      :punt_yards, 
      :punt_avg,   
      :punt_long,  
      :in_20,      
      :in_10,      
      :fc,         
      :tb,         
      :blk]
  end
  
end