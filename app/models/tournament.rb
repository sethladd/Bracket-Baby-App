class Tournament < ActiveRecord::Base
  has_many :participants, :include => :user, :dependent => :destroy
  
  validates :name, :presence => true
  validates :starts_on, :ends_on, :date => {
    :message => 'must be on or after today', :after_or_equal_to => Proc.new{Date.today} },
    :on => :create
  validates :ends_on, :date => {
    :message => 'must be on or after start date', :after_or_equal_to => :starts_on }
  
  scope :in_progress, lambda { where('starts_on <= ? and ends_on >= ?', Date.today, Date.today) }
  scope :upcoming, lambda { where('starts_on > ?', Date.today) }
  scope :finished, lambda { where('ends_at < ?', Date.today) }
  
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
    (starts_on <= Date.today)
  end
  
  def ended?
    (ends_on <= Date.today)
  end
  
  def in_progress?
    today = Date.today
    (starts_on <= today && ends_on >= today)
  end
  
  def finished?
    (ends_onDate.today < Date.today)
  end
  
  def upcoming?
    !started?
  end
  
  def participating?(user)
    !participants.where(:user_id => user.id).first.nil?
  end
  
  def start!
    Tournament.transaction do
      confirmed_participants.in_groups_of(2).map{|g| g.compact}.select{|g| g.length == 2}.each do |group|
        Match.create!(:participant1 => group.first,
                      :participant2 => group.last,
                      :tournament => self,
                      :first_day => Date.today,
                      :last_day => Date.today)
      end
    end
  end
  
  private
  
  def end_date_is_greater_than_start_date
    if ends_at < starts_at
      errors.add(:ends_at, "must be on or after the start date")
    end
  end
end