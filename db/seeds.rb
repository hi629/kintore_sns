# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do |i|
    Post.create!(
        user_id:5,
        text:"##{i}seeds user_id:5",
        image:File.open("./app/assets/images/test#{i+1}.jpg")
    )
end
