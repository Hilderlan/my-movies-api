class Movie < ApplicationRecord
  belongs_to :user

  validates_presence_of :title, :description, :director, :duration_min, :release_year
end
