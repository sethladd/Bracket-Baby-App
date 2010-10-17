class Tournament < ActiveRecord::Base
  has_many :registrations, :include => :user, :dependent => :destroy
  has_many :brackets, :dependent => :destroy
  has_many :matches, :through => :brackets
  
  validates :name, :should_start_at, :should_end_at, :match_length_seconds, :presence => true
  validates :should_start_at, :should_end_at, :date => {
    :message => 'must be on or after today', :after_or_equal_to => Proc.new{Date.today} },
    :on => :create
  validates :should_end_at, :date => {
    :message => 'must be on or after start date', :after_or_equal_to => :should_start_at }
  validates :match_length_seconds, :minimum_bracket_size, :numericality => {:greater_than => 0}
  
  scope :upcoming, lambda { where('should_start_at > ?', Time.now.utc) }
  scope :should_start, lambda { where('should_start_at <= ?', Time.now.utc).where('started_at is null') }
  scope :should_end, lambda { where('should_end_at <= ?', Time.now.utc).where('ended_at is null') }
  
  scope :started, where('started_at is not null')
  scope :ended, where('ended_at is not null')
  scope :not_ended, where('ended_at is null')
  scope :in_progress, started.not_ended
  
  scope :started_or_should_start, lambda { where('should_start_at <= ?', Time.now.utc).not_ended }
  
  def match_length_hours
    return nil if match_length_seconds.nil?
    match_length_seconds / 60 / 60.0
  end
  
  def match_length_hours=(hours)
    self.match_length_seconds = hours.to_f.hours.seconds
  end
  
  def max_players_per_bracket
    (maximum_bracket_size > 0) ? maximum_bracket_size : (2 ** max_number_of_rounds)
  end
  
  def max_number_of_rounds
    ((should_end_at - should_start_at) / match_length_seconds).floor
  end
  
  def quorum_for_at_least_one_bracket?
    registrations_count >= minimum_bracket_size
  end
      
  def can_join?(user)
    !should_start? && !registered?(user)
  end
  
  def can_quit?(user)
    !should_start? && registered?(user)
  end
  
  def should_start?
    should_start_at <= Time.now.utc
  end
  
  def should_end?
    should_end_at <= Time.now.utc
  end
  
  def started?
    !started_at.nil?
  end
  
  def ended?
    !ended_at.nil?
  end
  
  def in_progress?
    started? && !ended?
  end

  def registered?(user)
    !registration_for_user(user).nil?
  end
  
  def registration_for_user(user)
    registrations.where(:user_id => user.id).first
  end
  
  def finished?
    brackets.all?{|b| b.finished?}
  end
  
  def start!
    Tournament.transaction do
      # TODO: stream from db
      registrations.order('created_at').in_groups_of(max_players_per_bracket).map do |g|
        # remove any nils, the last group might have some
        g.compact
      end.select do |g|
        # ensure we have a quorum
        g.size >= minimum_bracket_size
      end.each do |g|
        # if more than a quorum but less than a factor of 2, shrink until a factor of 2
        max_size = max_players_per_bracket
        next if g.size == max_size
        while (max_size > g.size)
          max_size = max_size >> 1
        end
        g.slice!(max_size..-1)
      end.map do |g|
        # randomize the players
        g.sort_by{rand}
      end.each do |registrations|
        # place into brackets
        bracket = self.brackets.create!
        round_num = 0
        matches = registrations.in_groups_of(2).map do |match_pair|
          now = Time.now.utc
          match_should_start_at = self.should_start_at < now ? now : self.should_start_at
          match = bracket.matches.create!(
            :should_start_at => match_should_start_at,
            :match_length_seconds => match_length_seconds,
            :round => round_num
          )
          match_pair.each do |registration|
            registration.confirm!
            match.match_players.create!(:user => registration.user)
          end
          match
        end
        while matches.length > 1
          round_num += 1
          matches = matches.in_groups_of(2).map do |group|
            bracket.matches.create!(
              :preceding_match1 => group.first,
              :preceding_match2 => group.last,
              :match_length_seconds => match_length_seconds,
              :round => round_num
            )
          end
        end
        matches.first.update_attributes!(:finals => true)
        bracket.update_attributes!(:number_of_rounds => round_num+1)
      end
      self.update_attributes!(:started_at => Time.now.utc)
    end
  end
  
  def end!
    self.update_attributes!(:ended_at => Time.now.utc)
  end
  
  private
  
  def end_date_is_greater_than_start_date
    if should_end_at < should_start_at
      errors.add(:should_end_at, "must be on or after 'should starts at'")
    end
  end
end