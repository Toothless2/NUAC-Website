# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first

Role.create([{ name: "user", admin: false, canPost: false, canEvent: false, canEditHeader: false }, { name: "committee", admin: false, canPost: true, canEvent: true, canEditHeader: false }, { name: "admin", admin: true, canPost: true, canEvent: true, canEditHeader: true }])

User.all.each{ |u| u.role = Role.find_by(name: 'user'); u.save}