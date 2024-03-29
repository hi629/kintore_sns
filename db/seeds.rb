# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

2.times do |i|
    User.create!(email:"test#{i}@test.com", name:"test#{i}", username:"test#{i}test#{i}", password:"12345678")
    10.times do |j|
        Post.create!(
            user_id:i+2,
            text:"##{j}seeds user_id#{j}",
            image:File.open("./app/assets/images/test#{j+1}.jpg")
        )
    end
end

