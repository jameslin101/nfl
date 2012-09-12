class User
  include Mongoid::Document
  #include Mongo::Voter
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable


  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :username,
                  :terms_of_service

  has_many :polls
  has_and_belongs_to_many :poll_options

  field :provider,          :type => String
  field :uid,               :type => String
  field :first_name,        :type => String
  field :last_name,         :type => String
  field :username,          :type => String
  field :oauth_token,       :type => String
  field :oauth_expires_at,  :type => Time 
  field :image,             :type => String
  field :urls,              :type => Hash
  field :location,          :type => String
  field :verified,          :type => Boolean
  field :terms_of_service,  :type => Integer, :default => 0
  
  
  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""
  
  #validates_presence_of :email
  #validates_presence_of :encrypted_password
  validates_acceptance_of :terms_of_service, :accept => 1 
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :username

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String

  def abbr_name
    if self.first_name && self.last_name
      return self.first_name.to_s + " " + self.last_name[0].to_s + "."
    end
  end

  def display_name
    if !username.blank?
      return username
    end
    if !abbr_name.blank?
      return abbr_name
    end
    if !uid.blank?
      return uid
    end
    if !email.blank?
      return email
    end
      
    
  end

  
  def self.from_omniauth(auth)
    user = where(auth.slice(:provider, :uid)).first || where(auth.slice(:provider, :uid)).create
    user.provider = auth.provider
    user.uid = auth.uid
    user.email = auth.info.email
    user.first_name = auth.info.first_name
    user.last_name = auth.info.last_name
    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    user.image = auth.info.image   
    user.urls = auth.info.urls    
    user.location = auth.info.url
    user.verified = auth.info.verified
    user.save!
    user
  end
  
  
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && self.provider.blank?
  end

  def update_with_password(params, *options)
    if self.encrypted_password.blank?
      self.update_attributes(params, *options)
    else
      super
    end
  end
  
  def fiq
    fiq = 0
    self.poll_options.each do |p|
      fiq += p.points_right
      fiq -= p.points_wrong
    end
    fiq
  end
  
  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end
  
  def polls_voted(week = 0)
    if week > 0 
      @polls = self.poll_options.map{|i| if i.poll.week == week then i.poll end}
    else
      @polls = self.poll_options.map{|i| i.poll}
    end
    if @polls.length == 0 then 
      return nil
    else
      return @polls
    end
  end
end
