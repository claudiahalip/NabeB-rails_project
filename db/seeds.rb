# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Business.create(name: "H Photography", description: "H Photography is a Chicago land wedding photography and portrait studio business with highly recommended photographers. ", website: "https://www.thehphoto.com/", phone_number: "815-555-6666", category_id: "1", neighborhood_id: "2", user_id: "1") 
Business.create(name: "Vstudio", description: "videography service", website: "www.vstudio.com", phone_number: "847-777-7777", category_id: "2", neighborhood_id: "5", user_id: "2")
Business.create(name: "BookPublisher.inc", description: "publisher for children books", website: "www.bookpublisher.com", phone_number: "847-767-6767", category_id: "3", neighborhood_id: "5", user_id: "10")
Business.create(name: "MartinVideoEvent", description: "videography service", website: "www.martinvideoevents.com", phone_number: "847-657-17377", category_id: "2", neighborhood_id: "5", user_id: "7")
Business.create(name: "4 Season ", description: "air conditioning and heating service", website: "www.4seasons.com", phone_number: "847-477-5757", category_id: "4", neighborhood_id: "5", user_id: "16")