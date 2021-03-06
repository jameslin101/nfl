class NflPlayer
  include Mongoid::Document
  embeds_many :stats
  belongs_to :poll_option

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
  field :opp,       type: String
  field :season,    type: Integer
  field :game_time, type: Time
  field :_id,       type: String, default: ->{yahoo_id.to_s.parameterize}
  
  def to_json
    { "basic_data" => self.attributes    }
  end
  
  def name_team_pos
    self.name +
    " (" +
    self.team + 
    " - " +
    self.position + 
    ")"
  end
  
  def game_time_formatted
    if self.game_time
      self.game_time.localtime.strftime('%a %l:%M%P')
    end
  end
end
