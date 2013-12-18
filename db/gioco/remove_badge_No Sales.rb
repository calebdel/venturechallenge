kind = Kind.find_by_name('order_subtotal')
      badge = Badge.where( :name => 'No Sales', :kind_id => kind.id ).first
      badge.destroy
puts '> Badge successfully removed'