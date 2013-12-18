kind = Kind.find_by_name('Customer')
      badge = Badge.where( :name => 'Ten Customers', :kind_id => kind.id ).first
      badge.destroy
puts '> Badge successfully removed'