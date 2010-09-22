class User < ActiveRecord::Base
  has_many :participations, :class_name => 'Participant', :dependent => :destroy
  
  validates :identifier_url, :email, :first_name, :last_name, :presence => true
end