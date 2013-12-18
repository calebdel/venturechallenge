kind = Kind.find_or_create_by(name: 'Order_Subtotal')
badge = Badge.create({ 
                      :name => 'New Office', 
                      :points => '2000',
                      :kind_id  => kind.id,
                      :default => 'false'
                    })
puts '> Badge successfully created'