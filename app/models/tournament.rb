class Tournament < ActiveRecord::Base
  has_many :participants, :include => :user, :dependent => :destroy
  
  validates :name, :presence => true
  
  scope :in_progress, lambda { where('starts_at < ? and ends_at > ?', Time.now, Time.now) }
  scope :upcoming, lambda { where('starts_at > ?', Time.now) }
  scope :finished, lambda { where('ends_at < ?', Time.now) }
  
  def confirmed_participants
    participants.order('created_at').limit(confirmation_limit)
  end
  
  def waitlisted_participants
    participants.order('created_at').limit(1000).offset(confirmation_limit)
  end
  
  def confirmed?(user)
    confirmed_participants.where(:user_id => user.id)
  end
  
  def waitlisted?(user)
    participating?(user) && !confirmed?(user)
  end
      
  def can_join?(user)
    joinable? && !participating?(user)
  end
  
  def joinable?
    upcoming?
  end
  
  def started?
    (starts_at < Time.now)
  end
  
  def ended?
    (ends_at < Time.now)
  end
  
  def in_progress?
    now = Time.now
    (starts_at < now && ends_at > now)
  end
  
  def finished?
    (ends_at < Time.now)
  end
  
  def upcoming?
    !started?
  end
  
  def participating?(user)
    !participants.where(:user_id => user.id).first.nil?
  end
end