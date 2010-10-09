class Bracket < ActiveRecord::Base
  belongs_to :tournament, :counter_cache => true
  has_many :matches, :dependent => :destroy
  
  def finished?
    matches.finals_are_finished.count > 0
  end
end