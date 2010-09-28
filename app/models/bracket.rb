class Bracket < ActiveRecord::Base
  belongs_to :tournament
  has_many :matches, :dependent => :destroy
  
  def first_round_matches
    matches.select{|m| m.round == 0}
  end
end