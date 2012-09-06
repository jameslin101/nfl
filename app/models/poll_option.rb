class PollOption
  include Mongoid::Document
    
  belongs_to :poll
  attr_accessible :vote_count, :voters, :name, :nfl_player
  before_save :set_nfl_player
  
  field :name, type: String
  field :points_right, type: Integer, default: 0
  field :points_wrong, type: Integer, default: 0
  #field :vote_count, type: Integer, default: 0
  #field :voters, type: Array, default: []
  has_and_belongs_to_many :users
  has_one :nfl_player
  accepts_nested_attributes_for :nfl_player 
  
  
  def vote_up(user)
    if !voted?(user) && self.poll.can_vote?(user)
      self.users.push(user)
      save
      return true
    end
    return false
  end
  
  def unvote(user)
    if voted?(user)
      self.users.delete(user)
      save
      return true
    end
    return false
  end
  
  def voted?(user)
    self.users.include?(user) if user
  end
    
  def can_vote?(user)
    return !voted?(user) && self.poll.can_vote?(user)
  end
  
  def set_nfl_player
    if !self.name.nil?    
      k = self.name.split
      query = Array.new
      if k.count > 2
        full_name = k[0] + " " + k[1]
        query = NflPlayer.where(name: full_name)
      end
      if query.count == 1
        return self.nfl_player = query[0]
      else
        if query.count > 1
          team = k[2].sub("(","")
          return self.nfl_player = NflPlayer.where(name: full_name, team: team)[0]
        else
          errors[:valid_poll]= "Unable to find player: #{self.name}."
        end
      end
    end
  end
  
  def expired?
    return self.nfl_player.game_time < Time.now.utc if self.nfl_player
    return false
  end
  
  def display
    return nfl_player.name_team_pos if self.nfl_player
    return self.name
  end
end
