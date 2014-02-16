desc "This task is called by the Heroku scheduler add-on"
task :update_stats => :environment do
      @stores = Store.all
      @stores.each do |s|
        session = ShopifyAPI::Session.new(s.myshopify_domain, s.access_token)
        ShopifyAPI::Base.activate_session(session)
        orders = ShopifyAPI::Order.find(:all)
        orders.each do |o|
          @order = Order.new
          @order.subtotal_price = o.subtotal_price.to_f
          @order.referring_site = o.referring_site
          @order.total_discounts = o.total_discounts.to_i
          @order.store_id = s.id
          @order.league_id = s.league_id
          @order.shopify_id = o.id
          @order.save
        end
      end

end

