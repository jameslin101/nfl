class NflPlayer
  include Mongoid::Document
  embeds_many :stats
  
  field :name, type: String
  field :number, type: String
  field :position, type: String
  field :team, type: String
  field :height, type: String
  field :weight, type: String
  field :age, type: Integer
  field :born, type: String
  field :college, type: String
  field :draft, type: String
  
end
