class KStat < NflPlayer

  #Field Goals
  field :dist_0_19, type: String
  field :dist_19_29, type: String
  field :dist_30_39, type: String
  field :dist_40_49, type: String
  field :dist_50_plus, type: String
  field :fgm, type: Integer
  field :fga, type: Integer
  field :fg_pct, type: Float
  field :fg_long, type: Float

  #PAT
  field :xpm, type: Integer
  field :xpa, type: Integer
  field :pat_pct, type: Float

  #Points
  field :points, type: Integer
  
end