class Tournament < ActiveRecord::Base
  has_many :participants, :include => :user, :dependent => :destroy
  has_many :brackets, :dependent => :destroy
  has_many :matches, :through => :brackets
  
  validates :name, :starts_at, :ends_at, :match_length, :presence => true
  validates :starts_at, :ends_at, :date => {
    :message => 'must be on or after today', :after_or_equal_to => Proc.new{Date.today} },
    :on => :create
  validates :ends_at, :date => {
    :message => 'must be on or after start date', :after_or_equal_to => :starts_at }
  validates :match_length, :minimum_bracket_size, :numericality => {:greater_than => 0}
  
  scope :in_progress, lambda { where('starts_at <= ? and ends_at > ?', Time.now.utc, Time.now.utc) }
  scope :upcoming, lambda { where('starts_at > ?', Time.now.utc) }
  scope :finished, lambda { where('ends_at <= ?', Time.now.utc) }
  scope :ready_to_start, lambda { in_progress.where('started_at is null') }
  scope :ready_to_end, lambda { finished.where('ended_at is null') }
  
  def max_participants_per_bracket
    (maximum_bracket_size > 0) ? maximum_bracket_size : (2 ** max_number_of_rounds)
  end
  
  def max_number_of_rounds
    ((ends_at - starts_at) / 60 / 60 / match_length).floor
  end
  
  def estimated_number_of_brackets
    self.participants_count / max_participants_per_bracket
  end
      
  def can_join?(user)
    joinable? && !participating?(user)
  end
  
  def joinable?
    upcoming?
  end
  
  def upcoming?
    !started?
  end
  
  def started?
    (starts_at <= Time.now.utc)
  end
  
  def ended?
    (ends_at <= Time.now.utc)
  end
  
  def in_progress?
    now = Time.now.utc
    (starts_at <= now && ends_at > now)
  end

  def participating?(user)
    !participants.where(:user_id => user.id).first.nil?
  end
  
  def start!
    Tournament.transaction do
      # TODO: stream from db
      participants.order('created_at').in_groups_of(max_participants_per_bracket).each do |g|
        # remove any nils, the last group might have some
        g.compact!
      end.select do |g|
        # ensure we have a quorum
        g.size >= minimum_bracket_size
      end.each do |g|
        # if more than a quorum but less than a factor of 2, shrink until a factor of 2
        max_size = max_participants_per_bracket
        next if g.size == max_size
        while (max_size > g.size)
          max_size = max_size >> 1
        end
        g.slice!(max_size..-1)
      end.map do |g|
        # randomize the participants
        g.sort_by{rand}
      end.each do |match_participants|
        # place into brackets
        bracket = self.brackets.create!
        round_num = 0
        matches = match_participants.in_groups_of(2).map do |participants|
          now = Time.now.utc
          match_starts_at = self.starts_at < now ? now : self.starts_at
          match = bracket.matches.create!(
            :starts_at => match_starts_at,
            :ends_at => match_starts_at + match_length.hours,
            :round => round_num
          )
          participants.each do |participant|
            match.match_players.create!(:user => participant.user)
          end
          match
        end
        while matches.length > 1
          round_num += 1
          matches = matches.in_groups_of(2).map do |group|
            bracket.matches.create!(
              :preceding_match1 => group.first,
              :preceding_match2 => group.last,
              :starts_at => group.first.ends_at,
              :ends_at => group.first.ends_at + match_length.hours,
              :round => round_num
            )
          end
        end
        bracket.update_attributes!(:number_of_rounds => round_num+1)
      end
      self.update_attributes!(:started_at => Time.now.utc)
    end
  end
  
  private
  
  def end_date_is_greater_than_start_date
    if ends_at < starts_at
      errors.add(:ends_at, "must be on or after 'starts at'")
    end
  end
end