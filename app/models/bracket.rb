class Bracket < ActiveRecord::Base
  belongs_to :tournament, :counter_cache => true
  has_many :matches, :dependent => :destroy
  belongs_to :winner, :class_name => 'User'
  
  def finished?
    !self.winner_id.nil?
  end
end