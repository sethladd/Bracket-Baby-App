class Tournament < ActiveRecord::Base
  validates :name, :presence => true
  scope :in_progress, lambda { where('starts_at < ? and ends_at > ?', Time.now, Time.now) }
  scope :upcoming, lambda { where('starts_at > ?', Time.now) }
  scope :finished, lambda { where('ends_at < ?', Time.now)}
end