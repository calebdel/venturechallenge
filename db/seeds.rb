# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require "#{Rails.root}/db/gioco/db.rb"

# admin = User.create(name: "admin", email: "joshlamb@gmail.com", linkedin_uid: "aMOFVZLeHN", linkedin_token: "1c4ade61-cefe-47bd-9055-3546748c0b6a")

# league = League.create(name: "Test League", school: "Bitmaker", admin_id: admin.id, start_date: (Time.now-1209600), end_date:(Time.now+1209600), pin: 9999)

# student1 = User.create(name: "Technically Labs", url: "technically-labs.myshopify.com", shopify_token: "cc8fe5464cdad6c01def9a4a4c143d82", email: "apoon373@gmail.com")
# store1 = Store.create(user_id: student1.id, league_id: league.id)

# 10.times do
# 	createddate = Time.now-rand(1200000)
# 	order = Order.create(subtotal_price: Random.rand(200), store_id: store1.id, shopify_id: store1.id) 
# 	order.update_attributes(created_at: createddate)     
# 	store1.change_points({points:order.subtotal_price, type:1, kind:1})
# end

# student2 = User.create(name: "Obvious Dummy Shop", url: "obvious-dummy-shop.myshopify.com", shopify_token: "f4e521984fd18877b1c3f74ae844e91f", email: "joshlamb+obv@gmail.com")
# store2 = Store.create(user_id: student2.id, league_id: league.id)

# 6.times do
# 	createddate = Time.now-rand(1200000)
# 	order = Order.create(subtotal_price: Random.rand(200), store_id: store2.id, shopify_id: store2.id)  
# 	order.update_attributes(created_at: createddate)       
# 	store2.change_points({points:order.subtotal_price, type:1, kind:1})
# end

# Point.all.each do |point|
# 	createddate = Time.now-rand(1200000)
# 	point.update_attributes(created_at: createddate)
# end


