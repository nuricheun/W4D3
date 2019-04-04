# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do
    User.destroy_all
    user = User.new(username:"teapot")
    user.password = 'password'
    user.save!
    Cat.destroy_all
    c1 = Cat.create!(birth_date:'2001/2/3',color:'white',name:'fluffy',sex:'M', user_id: User.first.id)
    c2 = Cat.create!(birth_date:'2009/10/13',color:'brown',name:'mary',sex:'F', user_id: User.first.id)
end