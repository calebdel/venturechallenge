Rails.application.config.middleware.use OmniAuth::Builder do
  provider :shopify, 
           ShopifyApp.configuration.api_key, 
           ShopifyApp.configuration.secret,

           # Example permission scopes - see http://docs.shopify.com/api/tutorials/oauth for full listing
           :scope => 'read_orders, read_products, read_customers',

           :setup => lambda {|env| 
                       params = Rack::Utils.parse_query(env['QUERY_STRING'])
                       site_url = "https://#{params['shop']}"
                       env['omniauth.strategy'].options[:client_options][:site] = site_url
                     }
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, 
            "75dfkubtuvkdu2", 
            "DFfyeZpcjEf085oM",

            :scope => 'r_fullprofile r_emailaddress r_network',
            #:scope => 'r_basicprofile, r_fullprofile, r_emailaddress, r_network, r_contactinfo, rw_nus, rw_company_admin, rw_groups, w_messages',
            :fields => ["id", "email-address", "first-name", "last-name", "headline", "industry", "picture-url", "public-profile-url", "location", "connections"]
end
