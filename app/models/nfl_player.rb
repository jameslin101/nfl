class NflPlayer
  include Mongoid::Document
  embeds_many :stats

  field :yahoo_id,  type: String 
  field :name,      type: String
  field :number,    type: String
  field :position,  type: String
  field :team,      type: String
  field :height,    type: String
  field :weight,    type: String
  field :age,       type: Integer
  field :born,      type: String
  field :college,   type: String
  field :draft,     type: String
  field :_id,       type: String, default: ->{yahoo_id.to_s.parameterize}
  
  def to_json
    { "basic_data" => self.attributes    }
  end
  
  def name_team_pos
    self.name +
    " (" +
    NflPlayersHelper::team_abbr(self.team) + 
    " - " +
    NflPlayersHelper::position_abbr(self.position) + 
    ")"
  end
end
