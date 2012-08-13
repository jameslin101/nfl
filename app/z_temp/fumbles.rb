class Fumbles
  include Mongoid::Document
  
  field :fumbles, type: Integer
  field :fumbles_lost, type: Integer
  
  embedded_in: :fumbleable, polymorphic: true
  
end