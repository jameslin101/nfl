class Poll
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :user
  has_many :poll_options, :dependent => :destroy
  accepts_nested_attributes_for :poll_options, :allow_destroy => true
  attr_accessible :poll_options_attributes, :question, :week, :scoring, :note, :votes, :max_vote_options, :user_votes
  
  QUESTION_TYPES = ["Who should I start?",
                    "Who should I pick up?"]
                   
  SCORING_TYPES = ["Traditional",
                  "Performance",
                  "PPR"]
  
  field :question,          type: String
  field :week,              type: Integer
  field :scoring,           type: String, default: QUESTION_TYPES[0]
  field :note,              type: String
  field :votes,             type: Integer, default: 0
  field :max_vote_options,  type: Integer, default: 1
  field :user_votes,        type: Hash, default: {}
    

  
  def add_vote(user)
    v = 0
    if can_vote?(user)
      v = self.user_votes[user.email_clean] if self.user_votes[user.email_clean] 
      self.user_votes.store(user.email_clean, v+1)
      save
    else
      raise "wtf no vote?"
      return false
    end
    return v+1
  end
  
  def unvote(user)
    v = self.user_votes[user.email_clean]
    self.user_votes.store(user.email_clean, v-1)
    save
  end
  
  def can_vote?(user)
    if v = self.user_votes[user.email_clean]
      return v < self.max_vote_options
    else
      true
    end
  end
  
end