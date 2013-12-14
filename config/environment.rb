# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Venturechallenge::Application.initialize!

require "#{Rails.root}/db/gioco/create_badge_First Customer_Customer.rb"
require "#{Rails.root}/db/gioco/create_badge_First Sale_Order_Subtotal.rb"
require "#{Rails.root}/db/gioco/create_badge_Sales Intern_Order_Subtotal.rb"
require "#{Rails.root}/db/gioco/create_badge_Sales Manager_Order_Subtotal.rb"
require "#{Rails.root}/db/gioco/create_badge_VP of Sales_Order_Subtotal.rb"
require "#{Rails.root}/db/gioco/create_badge_CEO_Order_Subtotal.rb"
require "#{Rails.root}/db/gioco/create_badge_God Himself_Order_Subtotal.rb"
require "#{Rails.root}/db/gioco/create_badge_Bakers Dozen_Order_Count.rb"
require "#{Rails.root}/db/gioco/create_badge_Running Start_Order_Count.rb"
require "#{Rails.root}/db/gioco/create_badge_Coming Back For Me_Repeat Customer.rb"
require "#{Rails.root}/db/gioco/create_badge_Well Connected_Website_Referral.rb"
require "#{Rails.root}/db/gioco/create_badge_5 in a Day_Orders_today.rb"
require "#{Rails.root}/db/gioco/create_badge_The one that got away_Abandoned_cart.rb"
