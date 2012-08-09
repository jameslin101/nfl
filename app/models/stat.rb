class Stat
  include Mongoid::Document
  
  field :season, type: String
  field :team, type: String
  field :games, type: Integer
  
  embedded_in :nfl_player
  
  
end
