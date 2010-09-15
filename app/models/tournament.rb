class Tournament < ActiveRecord::Base
  scope :in_progress, lambda { where('started_at < ?', Time.now) }
  scope :upcoming, lambda { where('started_at > ?', Time.now) }
end