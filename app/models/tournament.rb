class Tournament < ActiveRecord::Base
  has_many :participants, :include => :user
  
  validates :name, :presence => true
  
  scope :in_progress, lambda { where('starts_at < ? and ends_at > ?', Time.now, Time.now) }
  scope :upcoming, lambda { where('starts_at > ?', Time.now) }
  scope :finished, lambda { where('ends_at < ?', Time.now)}
  
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
    (starts_at > Time.now)
  end
  
  def participating?(user)
    participants.any?{|p| p.user == user}
  end
end