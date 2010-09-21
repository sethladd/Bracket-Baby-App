class Tournament < ActiveRecord::Base
  has_many :participants, :include => :user, :dependent => :destroy
  has_many :matches, :dependent => :destroy
  
  validates :name, :starts_at, :ends_at, :time_zone, :presence => true
  validates :starts_at, :ends_at, :date => {
    :message => 'must be on or after today', :after_or_equal_to => Proc.new{Date.today} },
    :on => :create
  validates :ends_at, :date => {
    :message => 'must be on or after start date', :after_or_equal_to => :starts_at }
  
  scope :in_progress, lambda { where('starts_at <= ? and ends_at > ?', Time.now.utc, Time.now.utc) }
  scope :upcoming, lambda { where('starts_at > ?', Time.now.utc) }
  scope :finished, lambda { where('ends_at <= ?', Time.now.utc) }
  
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
    (starts_at <= Date.today)
  end
  
  def ended?
    (ends_at <= Date.today)
  end
  
  def in_progress?
    now = Time.now.utc
    (starts_at <= now && ends_at > now)
  end
  
  def upcoming?
    !started?
  end
  
  def participating?(user)
    !participants.where(:user_id => user.id).first.nil?
  end
  
  def start!
    Tournament.transaction do
      matches = confirmed_participants.sort_by{rand}.in_groups_of(2).map{|g| g.compact}.select{|g| g.length == 2}.map do |group|
        Match.create!(:participant1 => group.first,
                      :participant2 => group.last,
                      :tournament => self,
                      :starts_at => self.starts_at,
                      :ends_at => self.starts_at + 1.day)
      end
      while matches.length > 1
        matches = matches.in_groups_of(2).map do |group|
          Match.create!(:preceding_match1 => group.first,
                        :preceding_match2 => group.last,
                        :starts_at => group.first.ends_at,
                        :ends_at => group.first.ends_at + 1.day,
                        :tournament => self)
        end
      end
    end
  end
  
  private
  
  def end_date_is_greater_than_start_date
    if ends_at < starts_at
      errors.add(:ends_at, "must be on or after 'starts at'")
    end
  end
end