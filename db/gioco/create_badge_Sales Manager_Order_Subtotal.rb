kind = Kind.find_or_create_by(name: 'Order_Subtotal')
badge = Badge.create({ 
                      :name => 'Sales Manager', 
                      :points => '250',
                      :kind_id  => kind.id,
                      :default => 'false'
                    })
puts '> Badge successfully created'