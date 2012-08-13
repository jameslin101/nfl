class Stat
  include Mongoid::Document
  
  field :season, type: String
  field :team, type: String
  field :games, type: Integer
  field :_id, type: String, default: ->{season.to_s.parameterize}
  
  attr_accessible :season, :team, :games
  embedded_in :nfl_player
  
  
end
