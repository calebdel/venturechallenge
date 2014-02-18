desc "This task is called by the Heroku scheduler add-on"
task :update_stats => :environment do
      @users = User.all
      @users.each do |s|
        session = ShopifyAPI::Session.new(s.url, s.shopify_token)
        ShopifyAPI::Base.activate_session(session)
        orders = ShopifyAPI::Order.where(:league_id => '5')
        orders.each do |o|
          @order = Order.new
          @order.subtotal_price = o.subtotal_price.to_f
          @order.referring_site = o.referring_site
          @order.total_discounts = o.total_discounts.to_i
          @order.store_id = '5'
          @order.shopify_id = o.id
          @order.save
        end
      end

end

