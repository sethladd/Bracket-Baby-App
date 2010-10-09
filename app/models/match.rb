class Match < ActiveRecord::Base
  has_many   :match_players, :dependent => :destroy
  belongs_to :bracket
  belongs_to :winner, :class_name => 'User'
  belongs_to :preceding_match1, :class_name => 'Match'
  belongs_to :preceding_match2, :class_name => 'Match'
  
  validates :bracket_id, :round, :match_length, :presence => true
  
  scope :should_start, lambda {
    where(:external_game_uri => nil).
    where('should_start_at <= ?', Time.now.utc).
    where(:started_at => nil).
    where(:match_players_count => 2)
  }
  
  scope :started, where('started_at is not null')
  scope :in_progress, where('started_at is not null').where('ended_at is null')
  scope :ended, where('ended_at is not null')
  
  def next_match
    Match.where('preceding_match1_id = ? OR preceding_match2_id = ?', self.id, self.id).first
  end
  
  def preceded_by?(preceding_match)
    (preceding_match1 == preceding_match || preceding_match2 == preceding_match)
  end
  
  def start!(external_game_uri)
    raise "not scheduled to start yet or already started" unless should_start?
    
    now = Time.now.utc
    self.update_attributes!(
      :external_game_uri => external_game_uri,
      :started_at => now,
      :should_end_at => now + match_length.hours
    )
  end
  
  def should_start?
    external_game_uri.nil? &&
    should_start_at <= Time.now.utc &&
    started_at.nil? &&
    match_players_count == 2
  end
  
  def update_game_state!(game_state)
    Match.transaction do
      self.updated_from_server_at = Time.now.utc
      
      game_state['players'].each do |player|
        match_player = match_players.detect{|mp| mp.user.email == player['email']}
        match_player.update_attributes!(:score => player['score'])
      end
    
      unless game_state['winner'].blank?
        match.end!(game_state)
      end
    
      self.save!
    end
  end
  
  def end!(game_state)
    Match.transaction do
      winner_email = game_state['winner']
      winning_player = match_players.detect{|mp| mp.user.email == winner_email}
      winning_player.update_attributes!(:winner => true)
      winning_user = winning_player.user
      update_attributes!({
        :winner => winning_user,
        :ended_at => Time.now.utc
      })
      unless finals?
        next_match.match_players.create!(:user => winning_user)
      end
    end
  end
  
  def started?
    !started_at.nil?
  end
end