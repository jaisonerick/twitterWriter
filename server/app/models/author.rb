class Author < ActiveRecord::Base
  has_many :twits

  validates :name, presence: true
  validates :screen_name, presence: true,
                          uniqueness: true

  validates :twitter_id, presence: true,
                         uniqueness: true


end
