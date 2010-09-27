class Match < ActiveRecord::Base
  belongs_to :participant1, :class_name => 'Participant'
  belongs_to :participant2, :class_name => 'Participant'
  belongs_to :bracket
  belongs_to :winner, :class_name => 'User'
  belongs_to :preceding_match1, :class_name => 'Match'
  belongs_to :preceding_match2, :class_name => 'Match'
  
  validates :bracket_id, :starts_at, :ends_at, :presence => true
end