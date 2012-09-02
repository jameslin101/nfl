class Stat
  include Mongoid::Document
  
  field :season, type: String
  field :week, type: Integer
  field :pass_yds, type: Integer
  field :pass_td, type: Integer
  field :intercept, type: Integer
  field :rush_yds, type: Integer
  field :rush_td, type: Integer
  field :rec, type: Integer
  field :rec_yds, type: Integer
  field :rec_td, type: Integer
  field :ret_td, type: Integer
  field :two_point, type: Integer
  field :fumble, type: Integer  
  field :pts_allow, type: Integer
  field :sack, type: Float
  field :safe, type: Integer
  field :def_int, type: Integer
  field :def_fumble, type: Integer
  field :def_td, type: Integer
  field :def_ret_td, type: Integer
  field :block_kick, type: Integer
  field :fg10, type: Integer
  field :fg20, type: Integer
  field :fg30, type: Integer
  field :fg40, type: Integer
  field :fg50, type: Integer
  field :pat, type: Integer 
  field :opp, type: String
  field :team, type: String
  field :games, type: Integer
  field :_id, type: String, default: ->{week.to_s.parameterize}
  
  attr_accessible :season, :team, :games
  embedded_in :nfl_player
  
  
end
