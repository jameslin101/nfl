class NflPlayer
  include Mongoid::Document
  embeds_many :stats
  
  field :name, type: String
  field :number, type: String
  field :team, type: String
  field :position, type: String
  field :height, type: String
  field :weight, type: String
  field :college, type: String
  
end
