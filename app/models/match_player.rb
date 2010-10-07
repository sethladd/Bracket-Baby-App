class MatchPlayer < ActiveRecord::Base
  belongs_to :match, :counter_cache => true
  belongs_to :user
  
  validates :match_id, :user_id, :score, :presence => true
  
  def nickname
    user.email.slice(0, user.email.index('@'))
  end
end