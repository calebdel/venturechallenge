class WebhooksController < ApplicationController
  before_filter :connect_to_store
  
  def product_new
      data = ActiveSupport::JSON.decode(request.body.read)
      shopify_id = data["id"]

      Product.new_from_shopify(@s, shopify_id)

      head :ok
    end

    private

    def connect_to_store

      shop_url = request.headers['HTTP_X_SHOPIFY_SHOP_DOMAIN']
      shop_url = ("http://" + shop_url)

      @s = Shop.find_by_url(shop_url)

      session = ShopifyAPI::Session.new(@s.url, @s.access_token)
      session.valid?
      ShopifyAPI::Base.activate_session(session)

    end
end
