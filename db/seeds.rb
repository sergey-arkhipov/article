# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

20.times do
  article = Article.new
  article.title = Faker::Lorem.paragraph_by_chars(number: 250)
  article.author = Faker::Name.name
  rand(1..5).times do
    Text.create(article: article, text: Faker::Lorem.paragraph_by_chars(number: 510))
  end
  article.save
end
