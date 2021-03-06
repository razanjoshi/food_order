# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

q = Product.create(title: 'Chicken Pizza', price: 3.5)
q.picture = Pathname.new(Rails.root.join("public/images/PizzaHut.jpg")).open
q.save

p = Product.create(title: 'Chicken Biryaani', price: 5.5)
p.picture = Pathname.new(Rails.root.join("public/images/biryani.jpg")).open
p.save
