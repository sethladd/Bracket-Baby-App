class User < ActiveRecord::Base
  validates :identifier_url, :email, :presence => true
end