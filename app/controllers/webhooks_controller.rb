class WebhooksController < ApplicationController
  before_filter :connect_to_store
  
    def product_new
      data = ActiveSupport::JSON.decode(request.body.read)
      shopify_id = data["id"]

      Product.new_from_shopify(@s, shopify_id)

      head :ok
    end

    def order_new
      data = ActiveSupport::JSON.decode(request.body.read)

      shop_url = request.headers['HTTP_X_SHOPIFY_SHOP_DOMAIN']
      unless Order.find_by_shopify_id(data["id"].to_s)
        neworder = ShopifyAPI::Order.find(data["id"].to_s)
        @order = Order.new
        @order.subtotal_price = neworder.subtotal_price.to_f
        @order.referring_site = neworder.referring_site
        @order.total_discounts = neworder.total_discounts.to_i
        @order.store_id = @u.id
        @order.shopify_id = neworder.id
        @order.save
        order_points(neworder.subtotal_price.to_f)
      end
      head :ok
    end

    def customers_new
      data = ActiveSupport::JSON.decode(request.body.read)
      shop_url = request.headers['HTTP_X_SHOPIFY_SHOP_DOMAIN']
      unless Customer.find_by_customer_id(data["id"].to_s)
        newcustomer = ShopifyAPI::Customer.find(data["id"].to_s)
        @customer = Customer.new
        # @customer.city = newcustomer[1].city
        @customer.accepts_marketing = newcustomer.accepts_marketing
        @customer.orders_count = newcustomer.orders_count
        @customer.total_spent = newcustomer.total_spent
        @customer.customer_id = @u.id

        @customer.save
        head :ok
        customer_points(10)
      end
        head :ok
     end


    private


    def connect_to_store
      shop_url = request.headers['HTTP_X_SHOPIFY_SHOP_DOMAIN']
      # shop_url = ("http://" + shop_url)

      @u = User.find_by_url(shop_url) #should be store?
      session = ShopifyAPI::Session.new(@u.url, @u.token)
      session.valid?
      ShopifyAPI::Base.activate_session(session)
    end

    def order_points(total)
      Store.find_by_user_id(@u.id).change_points({points:total, kind:2})
    end

    def customer_points(pts)
      Store.find_by_user_id(@u.id).change_points({points:pts, kind:1})
    end

end