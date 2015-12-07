# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#


user = User.create(email: "test", password: "test", password_confirmation: "test")
OmdbApi.search("Batman")
user.movies = Movie.last(2)
user.save
