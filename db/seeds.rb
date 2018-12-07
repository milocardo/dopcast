# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Examples:

#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Cleaning database...'
User.destroy_all
Episode.destroy_all
Playlist.destroy_all
Review.destroy_all
Podcast.destroy_all
Subscription.destroy_all

puts 'Creating users...'
ricardo = User.create!(email: 'ricardo@gmail.com', password: "123456", username: "Ricardo", country: "Brazil")
rodrigo = User.create!(email: 'rodrigo@gmail.com', password: "123456", username: "Rodrigo", country: "Brazil")
manoel = User.create!(email: 'manoel@gmail.com', password: "123456", username: "Manoel", country: "Brazil")
milene = User.create!(email: 'milene@gmail.com', password: "123456", username: "Milene", country: "France")

# puts 'Creating podcasts...'

# 1.upto(10) do |i|
#   random_image = rand(100..900)
#   language = ["Portuguese", "French", "Spanish"].sample
#   category = ["Science", "Music", "Economy"].sample
#   Podcast.create!(image: "https://picsum.photos/200/200/?#{random_image}",title: "Podcast #{i}", category: "#{category}", language: "#{language}", description: "Lorem ipsum dolor")
# end

# puts 'Creating episodes...'
# podcasts = Podcast.all
# podcasts.each do |podcast|
#   1.upto(10) do |i|
#     Episode.create!(podcast: podcast, title: "Episode #{i}", description: "Lorem ipsum dolor")
#   end
# end
# puts 'Finished!'
