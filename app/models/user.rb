class User < ActiveRecord::Base
  has_many :participations, :class_name => 'Participant'
  validates :identifier_url, :email, :presence => true
end