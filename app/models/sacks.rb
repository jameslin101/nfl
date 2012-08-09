class Sacks
  include Mongoid::Document
  
  field :sacks, type: Integer
  field :yards_lost, type: Integer
  
  embedded_in: :sackable, polymorphic: true
  
end