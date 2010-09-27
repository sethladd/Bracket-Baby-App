class User < ActiveRecord::Base
  has_many :participations, :class_name => 'Participant', :dependent => :destroy
  
  validates :identifier_url, :email, :presence => true
  validates :first_name, :last_name, :time_zone, :presence => true, :on => :update
end