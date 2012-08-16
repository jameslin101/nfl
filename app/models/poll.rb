class Poll
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :user
  embeds_many :poll_options
  
  
  field :question, type: String
  field :week, type: Integer
  field :scoring, type: String
  field :notes, type: Text
  
    
  QUESTIONTYPES = %w(
                    Who should I start?,
                    Who should I pick up?
                    )
  SCORINGTYPE = %w(
                  Traditional,
                  Performance,
                  PPR
                  )
  
  
  
end
