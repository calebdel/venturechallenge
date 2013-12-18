kind = Kind.find_by_name('Customers')
      badge = Badge.where( :name => 'First Customer', :kind_id => kind.id ).first
      badge.destroy
puts '> Badge successfully removed'