class Match < ActiveRecord::Base
  belongs_to :participant1, :include => :user, :class_name => 'Participant'
  belongs_to :participant2, :include => :user, :class_name => 'Participant'
  belongs_to :bracket
  belongs_to :winner, :class_name => 'User'
  belongs_to :preceding_match1, :class_name => 'Match'
  belongs_to :preceding_match2, :class_name => 'Match'
  
  validates :bracket_id, :starts_at, :round, :ends_at, :presence => true
  
  def preceded_by?(preceding_match)
    (preceding_match1 == preceding_match || preceding_match2 == preceding_match)
  end
end