# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.create(role_name: "Super Admin", role_description:"It has the all access like creating/updating and deleting a user and assigning role to any user")
role_id_sa = Role.find_by(role_name: "Super Admin").id
User.create(email: "super_admin@gmail.com", password:"123456", role_id: role_id_sa, creator_user_id: 1)

Role.create(role_name: "Admin", role_description:"It has the all access except creating/updating and deleting a user and assigning role to any user")
Role.create(role_name: "Publisher", role_description:"It has the access to fetch news from Provider URL and can read, write, delete and update the provider url and news")
Role.create(role_name: "Editor", role_description:"It has the access to read the news")

Role.create(role_name: "Creator", role_description:"It has the access to fetch news from Provider URL and can read the provider url and news")
Role.create(role_name: "Author", role_description:"It has the access to read, creating, updating and deleting the news")


role_id_a = Role.find_by(role_name: "Admin").id
role_id_p = Role.find_by(role_name: "Publisher").id
User.create(email: "admin@gmail.com", password:"123456", role_id: role_id_a)
User.create(email: "publisher@gmail.com", password:"123456", role_id: role_id_p)

