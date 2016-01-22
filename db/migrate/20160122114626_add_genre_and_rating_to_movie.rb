class AddGenreAndRatingToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :genre, :string
    add_column :movies, :imdb_rating, :string
    add_column :movies, :imdb_type, :string
  end
end
