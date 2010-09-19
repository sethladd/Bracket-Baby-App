class Match < ActiveRecord::Base
  belongs_to :participant1
  belongs_to :participant2
  belongs_to :tournament
  
  validates :participant1_id, :participant2_id, :tournament_id
end