class Match < ActiveRecord::Base
  has_many   :match_players, :dependent => :destroy
  belongs_to :bracket
  belongs_to :winner, :class_name => 'User'
  belongs_to :preceding_match1, :class_name => 'Match'
  belongs_to :preceding_match2, :class_name => 'Match'
  
  validates :bracket_id, :starts_at, :round, :ends_at, :presence => true
  
  scope :ready_to_start, lambda {
    where(:external_game_uri => nil).
    where('starts_at <= ?', Time.now.utc).
    where(:started_at => nil).
    where(:match_players_count => 2)
  }
  
  scope :in_progress, where('started_at is not null AND ended_at is null')
  
  def next_match
    Match.where('preceding_match1_id = ? OR preceding_match2_id = ?', self.id, self.id).first
  end
  
  def preceded_by?(preceding_match)
    (preceding_match1 == preceding_match || preceding_match2 == preceding_match)
  end
  
  def start!(external_game_uri)
    self.update_attributes!(:external_name_uri => external_game_uri, :started_at => Time.now.utc)
  end
  
  def update_game_state!(game_state)
    Match.transaction do
      game_state['players'].each do |player|
        match_player = match_players.detect{|mp| mp.user.email == player['email']}
        match_player.update_attributes!(:score => player['score'])
      end
    
      winner_email = game_state['winner']
      unless winner_email.blank?
        match.end!(game_state)
      end
    
      self.save!
    end
  end
  
  def end!(game_state)
    Match.transaction do
      winner_email = game_state['winner']
      winning_user = match_players.detect{|mp| mp.user.email == winner_email}.user
      update_attributes!({
        :winner => winning_user,
        :ended_at => Time.now.utc
      })
      next_match.match_players.create!(:user => winning_user)
    end
  end
end