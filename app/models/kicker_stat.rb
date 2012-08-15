class KickerStat < Stat

  embedded_in :kicker
  
  #Field Goals
  field :dist_0_19,     type: String
  field :dist_19_29,    type: String
  field :dist_30_39,    type: String
  field :dist_40_49,    type: String
  field :dist_50_plus,  type: String
  field :fgm,           type: Integer
  field :fga,           type: Integer
  field :fg_pct,        type: Float
  field :fg_long,       type: Float

  #PAT
  field :xpm,           type: Integer
  field :xpa,           type: Integer
  field :pat_pct,       type: Float

  #Points
  field :points,        type: Integer
  
  def stat_display_order
    [ :season,
      :team,
      :games,
      :dist_0_19,    
      :dist_19_29,   
      :dist_30_39,   
      :dist_40_49,   
      :dist_50_plus, 
      :fgm,          
      :fga,          
      :fg_pct,       
      :fg_long,      
      :xpm,          
      :xpa,          
      :pat_pct,      
      :points]
  end
end
