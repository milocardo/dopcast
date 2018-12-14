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
claudio = User.create!(email: 'claudio@gmail.com', password: "123456", username: "Claudio", country: "Brazil")
otavio = User.create!(email: 'otavio@gmail.com', password: "123456", username: "Otavio", country: "Brazil")
renato = User.create!(email: 'renato@gmail.com', password: "123456", username: "Renato", country: "Brazil")
laura = User.create!(email: 'laura@gmail.com', password: "123456", username: "Laura", country: "France")
daniel = User.create!(email: 'daniel@gmail.com', password: "123456", username: "Daniel", country: "Brazil")
bruno = User.create!(email: 'bruno@gmail.com', password: "123456", username: "Bruno", country: "Brazil")
justin = User.create!(email: 'justin@gmail.com', password: "123456", username: "Justin", country: "USA")
manuel = User.create!(email: 'manuel@gmail.com', password: "123456", username: "Manuel", country: "Germany")
richard = User.create!(email: 'richard@gmail.com', password: "123456", username: "Richard", country: "Netherland")
steven = User.create!(email: 'steven@gmail.com', password: "123456", username: "Steven", country: "USA")
gianluca = User.create!(email: 'gianluca@gmail.com', password: "123456", username: "Gianluca", country: "Brazil")
joao = User.create!(email: 'joao@gmail.com', password: "123456", username: "João", country: "Brazil")
caio = User.create!(email: 'caio@gmail.com', password: "123456", username: "Caio", country: "Brazil")
pedro = User.create!(email: 'pedro@gmail.com', password: "123456", username: "Pedro", country: "Brazil")



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
