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
        @order = Order.new
        @order.subtotal_price = data["subtotal_price"].to_f
        @order.referring_site = data["referring_site"]
        @order.total_discounts = data["total_discounts"].to_i
        @order.store_id = @s.id
        @order.save
        head :ok
        order_points(@order.subtotal_price)
      end
        head :ok
    end

    private

    def connect_to_store
      shop_url = request.headers['HTTP_X_SHOPIFY_SHOP_DOMAIN']
      # shop_url = ("http://" + shop_url)

      @s = Store.find_by_myshopify_domain(shop_url) #should be store?
      session = ShopifyAPI::Session.new(@s.myshopify_domain, @s.access_token)
      session.valid?
      ShopifyAPI::Base.activate_session(session)
    end

    def order_points(total)
      @s.change_points({points:total, type:1, kind:1})
    end
end