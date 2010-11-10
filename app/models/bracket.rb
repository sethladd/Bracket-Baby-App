class Bracket < ActiveRecord::Base
  belongs_to :tournament, :counter_cache => true
  has_many :matches, :dependent => :destroy, :order => 'matches.id'
  belongs_to :winner, :class_name => 'User'
  
  def finished?
    !self.winner_id.nil?
  end
  
  def number_of_players
    2**self.number_of_rounds
  end
  
  def first_round_matches
    matches.select{|m| m.round == 0}
  end
end