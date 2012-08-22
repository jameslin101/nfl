class Poll
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :user
  has_many :poll_options, :dependent => :destroy
  accepts_nested_attributes_for :poll_options, :allow_destroy => true, :reject_if => :all_blank
  attr_accessible :poll_options_attributes, :question, :week, :scoring, :note, :votes, :max_vote_options, :user_votes, :user, :subtitle
  #validate :require_two_players
  validates :note, :length => {:maximum => 240}
  
  QUESTION_TYPES = ["Who should I start?",
                    "Who should I pick up?"]
                   
  SCORING_TYPES = ["Traditional",
                  "Performance",
                  "PPR"]
  
  field :question,          type: String
  field :subtitle,          type: String
  field :week,              type: Integer, default: DateHelper::get_week(Time.now)
  field :scoring,           type: String 
  field :note,              type: String
  field :votes,             type: Integer, default: 0
  field :max_vote_options,  type: Integer, default: 1
  field :user_votes,        type: Hash, default: {}
  
  def add_vote(user)
    if can_vote?(user)
      if self.user_votes[user.email_clean] 
        v = self.user_votes[user.email_clean]
      else
        v = 0
        self.votes += 1
      end 
      self.user_votes.store(user.email_clean, v+1)
      save
    else
      return false
    end
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
  
  def get_user_votes(user)
    if v = self.user_votes[user.email_clean]
      return v
    else
      return 0
    end
  end
  
  private
    def require_two_players
      if self.poll_options.reject(&:marked_for_destruction?).length < 2
        errors[:two_players]= "You must provide at least 2 players."
      end
    end

    
  
end