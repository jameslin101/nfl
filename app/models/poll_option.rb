class PollOption
  include Mongoid::Document
  #include Mongo::Voteable
  
  belongs_to :poll
  attr_accessible :vote_count, :voters, :name
  
  #has_one :nfl_player
  field :name, type: String
  field :vote_count, type: Integer, default: 0
  field :voters, type: Array, default: []
  
  
  def vote_up(user)
    if !voted?(user) && self.poll.add_vote(user)
      self.vote_count += 1
      self.voters << user.email_clean
      save
    end
  end
  
  def unvote(user)
    self.poll.unvote(user)
    if voted?(user)
      self.vote_count -= 1
      self.voters.delete(user.email_clean)
      save
    end
  end
  
  def voted?(user)
    return self.voters.include?(user.email_clean) 
  end
  
  def can_vote?(user)
    return !voted?(user) && self.poll.can_vote?(user)
  end
end
