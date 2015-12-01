class ChangeReleaseOnMovies < ActiveRecord::Migration
  def change
    change_column :movies, :release, :string
  end
end
