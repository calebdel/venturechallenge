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

      @order = Order.new
      @order.json = data

      @s = Store.find_by_myshopify_domain(shop_url)

      @order.store_id = @s.id

      @order.save

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
end
