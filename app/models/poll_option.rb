class PollOption
  include Mongoid::Document
  #include Mongo::Voteable
  
  belongs_to :poll
  attr_accessible :vote_count, :voters, :name
  
  #has_one :nfl_player
  field :name, type: String
  field :points, type: Integer, default: 0
  #field :vote_count, type: Integer, default: 0
  #field :voters, type: Array, default: []
  has_and_belongs_to_many :users
  
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
  
  def nfl_player
    k = self.name.split
    return nil
    if k.count == 5
      full_name = k[0] + " " + k[1]
      team = NflPlayersHelper::team_abbr(k[2].sub("(",""))
      NflPlayer.where(name: full_name, team: team)[0]
    else
      return nil
    end
  end
end
