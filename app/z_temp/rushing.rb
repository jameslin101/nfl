class Rushing
  # include Mongoid::Document
  
  field :rushes, type: Float
  field :yards, type: Integer
  field :yards_per_game, type: Float
  field :yards_per_rush, type: Float
  field :tds, type: Integer
  
  embedded_in :rushable, polymorphic: true
  
end
