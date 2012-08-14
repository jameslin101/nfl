class PunterStat < Stat

  embedded_in :punter
  
  #Punting
  field :punts, type: Integer
  field :punt_yards, type: Integer
  field :punt_avg, type: Float
  field :punt_long, type: Integer
  field :in_20, type: Integer
  field :in_10, type: Integer
  field :fc, type: Integer
  field :tb, type: Integer
  field :blk, type: Integer

end