class Participant < ActiveRecord::Base
  belongs_to :tournament, :counter_cache => true
  belongs_to :user
  
  validates :tournament_id, :user_id, :presence => true
end