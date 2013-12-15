# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require "#{Rails.root}/db/gioco/db.rb"

admin = User.create(name: "admin", email: "joshlamb@gmail.com", linkedin_uid: "aMOFVZLeHN", linkedin_token: "1c4ade61-cefe-47bd-9055-3546748c0b6a")

league = League.create(name: "Test League", school: "Bitmaker", admin_id: admin.id, start_date: "2013-12-15 08:00:00", end_date:"2013-12-15 08:00:00")

student1 = User.create(name: "Obvious Dummy Shop", url: "obvious-dummy-shop.myshopify.com", shopify_token: "03088df25073dfefef16f77eb8b2e17d", email: "joshlamb+ods@gmail.com")

store = Store.create(user_id: student1.id, league_id: league.id)

10.times do
	order = Order.create(subtotal_price: Random.rand(200), store_id: store.id, shopify_id: store.id)      
	store.change_points({points:order.subtotal_price, type:1, kind:1})
end