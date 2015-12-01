class Movie < ActiveRecord::Base
  has_and_belongs_to_many :users
  mount_uploader :poster, PosterUploader
end
