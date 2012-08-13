class Passing
  include Mongoid::Document  
    
  field :qb_rating, type: Float
  field :comps, type: Integer
  field :atts, type: Integer
  field :pct, type: Float
  field :passing_yards, type: Integer
  field :passing_yards_per_game, type: Float
  field :yards_per_pass, type: Float
  field :passing_tds, type: Integer
  field :ints, type: Integer
    
  embedded_in: :qb_stat, polymorphic: true
  
end