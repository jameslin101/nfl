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

    
  belongs_to :user
  has_many :poll_options
  accepts_nested_attributes_for :poll_options  
  

  
end