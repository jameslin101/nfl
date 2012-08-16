class PollOption
  include Mongoid::Document
  include Mongo::Voteable
  
  has_one :nfl_player
  
  voteable self, :up => +1
  
end
