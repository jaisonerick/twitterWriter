class Twit < ActiveRecord::Base
  class DuplicatedException < StandardError; end

  belongs_to :author

  validates :body, presence: true
  validates :origin_id, presence: true
  validates :origin_id, uniqueness: true, strict: DuplicatedException

  validates_associated :author

  # Find the one user that has created the most number of
  # twits of all times. Returns just her screen name and
  # the number of twits.
  def self.most_active_user
    select('authors.screen_name, count(twits.id) as total')
    .joins(:author)
    .order('total DESC')
    .limit(1)
    .group('authors.screen_name')
  end

  # Find the number of Twits created by time of the day.
  # Returns just the hour and the total
  def self.by_hour
    select('EXTRACT(hour from twit_date) as hour, count(id) as total').group('hour')
  end

end
