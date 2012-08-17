class Poll
  include Mongoid::Document
  include Mongoid::Timestamps
  
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
  field :user_votes         type: Hash, default: {}
    
  belongs_to :user
  has_many :poll_options
  accepts_nested_attributes_for :poll_options  
  attr_accessible :question, :week, :scoring, :note, :votes, :max_vote_options, :user_votes
  
  def add_vote(user)
    if self.user_votes.has_key?(user._id)
      v = self.user_votes[user._id]
      if v < self.max_vote_options
        user_votes.store(user._id, v+1)
    else
      self.user_votes.
  
end