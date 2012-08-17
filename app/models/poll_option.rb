class PollOption
  include Mongoid::Document
  #include Mongo::Voteable
  
  belongs_to :poll
  
  #has_one :nfl_player
  field :option_test, type: String
  field :vote_count, type: Integer
  field :voters, type: Array, default: []
  
  attr_accessible :vote_count, :voters, :option_test
  
  def vote_up(user)
    self.vote_count = 0 if !self.vote_count
    if !voted(user)
      self.vote_count += 1
      self.voters << user._id
    end
    save
  end
  
  def unvote(user)
    if voted(user)
      self.vote_count -= 1
      self.voters.delete(user._id)
    end
    save
  end
  
  def voted(user)
    return self.voters.include?(user._id)
  end
end
