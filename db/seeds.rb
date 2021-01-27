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
Category.create(name: "photography")
Category.create(name: "videography")
Category.create(name: "publisher")
Category.create(name: "air conditioning & heating service")
Category.create(name: "dentist")
Category.create(name: "hair-stylist")
Category.create(name: "makeup artist")
Category.create(name: "vet")
Category.create(name: "food track")
Category.create(name: "music")
Category.create(name: "interior design")
Category.create(name: "nails salon")
Category.create(name: "event planner")
Category.create(name: "spa")
Category.create(name: "spa&gym")
Neighborhood.create(name: "Kimberley Farm", city: "Algonquin", state: "IL", zipcode: "60102")
Neighborhood.create(name: "Willowby Farm", city: "Algonquin", state: "IL", zipcode: "60102")
Neighborhood.create(name: "Ridge Park", city: "Chicago", state: "Illinois", zipcode: "60102-3266")
Neighborhood.create(name: "Lincoln Park", city: "Chicago", state: "Illinois", zipcode: "60614")
Neighborhood.create(name: "Armour Square", city: "Chicago", state: "Illinois", zipcode: "60616")
Neighborhood.create(name: "Little Village", city: "Chicago", state: "Illinois", zipcode: "60608")
Neighborhood.create(name: "Ridge Park", city: "Atlanta", state: "Georgia", zipcode: "30303")
Business.create(name: "AirConHeat", description: "air conditioning & heating service 24/7", website: "www.AirConHeat.com", phone_number: "815-516-0359", neighborhood_id: 5, category_id: 4)
Business.create(name: "VideoStudio", description: "videography service", website: "www.videostudio.com", phone_number: "616-234-6767", neighborhood_id: 6, category_id: 2)
Business.create(name: "MakeUpArtist", description: "makeup artist service", website: "www.makeupartist.com", phone_number: "616-235-6565", neighborhood_id: 1, category_id: 7)
Business.create(name: "Salon23", description: "hair style service", website: "www.salon23.com", phone_number: "615-233-4444", neighborhood_id: 4, category_id: 6)
Business.create(name: "BeautySmile", description: "dentist service", website: "www.beautysmile.com", phone_number: "672-747-9999", neighborhood_id: 6, category_id: 5)
Business.create(name: "BeautyStudio", description: "make up artist service", website: "www.beautystudio.com", phone_number: "516-222-2222", neighborhood_id: 6, category_id: 7)
Business.create(name: "LovelyFriendsVet", description: "vet office", website: "www.lovelyfriends.com", phone_number: "815-860-6743", neighborhood_id: 2, category_id: 8)
Business.create(name: "Jazzforyou&me", description: "jazz band", website: "www.jazzforyou.com", phone_number: "815-657-8999", neighborhood_id: 1, category_id: 10)
Business.create(name: "bigjazzband", description: "jazzband", website: "www.bigjazzband.com", phone_number: "815-676-9999", neighborhood_id: 2, category_id: 10)
Business.create(name: "bigband", description: "band", website: "www.bigband", phone_number: "815-787-9090", neighborhood_id: 5, category_id: 10)
Business.create(name: "Seafood", description: "the best seafood track", website: "www.seafood.com", phone_number: "8477499090", neighborhood_id: 6, category_id: 9)
Business.create(name: "MBinteriordesign", description: "interior design", website: "www.mbdesign.com", phone_number: "821-347-9090", neighborhood_id: 6, category_id: 11)
Business.create(name: "BeautyNails", description: "nails salon", website: "www.beautynails.com", phone_number: "816-21508365", neighborhood_id: 4, category_id: 12)
Business.create(name: "EventForYou", description: "event planner for all kind of events ", website: "www.eventforyou.com", phone_number: "714-234-0567", neighborhood_id: 4, category_id: 13)
Business.create(name: "AdaThePublisherInTown", description: "book publisher", website: "www.adathepublisher.com", phone_number: "815-666-2751", neighborhood_id: 2, category_id: 3)
