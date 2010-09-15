class Tournament < ActiveRecord::Base
  validates :name, :presence => true
  scope :in_progress, lambda { where('started_at < ?', Time.now) }
  scope :upcoming, lambda { where('started_at > ?', Time.now) }
end