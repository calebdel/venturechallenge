class WebhooksController < ApplicationController
  #initialize an API connection before recieving webhook
  before_filter :connect_to_store

    #new orders
    def order_new

      #f irst, save webhook object as data
      data = ActiveSupport::JSON.decode(request.body.read)
      # check if the order already exists and if it is within time range of league
      unless Order.find_by_shopify_id(data["id"].to_s) || out_of_dates  
        
        #if the webhook is new and within the league dates, retrieve it from the shopify API
        #this is done to ensure nothing has changed between the webhook event and the event itself
        neworder = ShopifyAPI::Order.find(data["id"].to_s) 

        # then save the order
        @order = Order.new
        @order.subtotal_price = neworder.subtotal_price.to_f
        @order.referring_site = neworder.referring_site
        @order.total_discounts = neworder.total_discounts.to_i
        @order.store_id = @s.id
        @order.league_id = @s.league_id
        @order.shopify_id = neworder.id
        @order.save

        #gioco method assigns points to the store
        order_points(neworder.subtotal_price.to_f)

        #checks to see if bonus points are due from challenge
        referral_challenge

        #creates the customer if they are new (for customers without shopify accounts)
        customer = Customer.find_or_create_by_email(data["email"].to_s, league_id: @s.league_id, orders_count: 0, total_spent: 0)
        
        #increases the total amount and order counters 
        customer.orders_count += 1
        customer.total_spent += neworder.subtotal_price.to_f
        customer.save
      end
      
      head :ok
    end

    #webhook for customers which do register shopify accounts
    def customers_new
      data = ActiveSupport::JSON.decode(request.body.read)
      newcustomer = ShopifyAPI::Customer.find(data["id"].to_s)
      unless Customer.find_by_email(data["email"].to_s) || out_of_dates 
        @customer = Customer.new
          @customer.orders_count = newcustomer.orders_count
          @customer.total_spent = newcustomer.total_spent
          @customer.city = newcustomer.default_address.city
          @customer.accepts_marketing = newcustomer.accepts_marketing
          @customer.customer_id = newcustomer.id
          @customer.store_id = @s.id
          @customer.save
          customer_points(10)
        end
      head :ok
    end

    private

    def out_of_dates
      return true unless @s.league #if the store is not assigned to a league return true
      Time.now < @s.league.start_date || Time.now > @s.league.end_date
    end


    def connect_to_store
      shop_url = request.headers['HTTP_X_SHOPIFY_SHOP_DOMAIN']
      @u = User.find_by_url(shop_url)
      @s = Store.find_by_user_id(@u.id)
      session = ShopifyAPI::Session.new(@u.url, @u.shopify_token)
      session.valid?
      ShopifyAPI::Base.activate_session(session)
    end

    # Adds "Order" points equal to subtotal_price to store when new_order webhook is created 
    def order_points(total)
      Store.find_by_user_id(@u.id).change_points({points:total, kind:2})
    end

    # Adds 10 "Customer" points to store when new_customer webhook is created 
    def customer_points(pts)
      Store.find_by_user_id(@u.id).change_points({points:pts, kind:1})
    end

    # Adds 2 "Facebook" points to store when new_order referring_site is equal to facebook 
    def referral_challenge
      if @order.referring_site.include? "facebook"
      Store.find_by_user_id(@u.id).change_points({points:2, kind:3})
      elsif @order.referring_site.include? "twitter"
        Store.find_by_user_id(@u.id).change_points({points:2, kind:4})
      elsif @order.referring_site.include? "pinterest"
        Store.find_by_user_id(@u.id).change_points({points:2, kind:5})
      else
        return nil
      end
    end


end