class Registration < ActiveRecord::Base
  belongs_to :tournament, :counter_cache => true
  belongs_to :user
  
  validates :tournament_id, :user_id, :presence => true
  
  attr_protected :confirmed
  
  scope :confirmed, where(:confirmed => true)
  
  def confirm!
    self.confirmed = true
    self.save!
  end
end