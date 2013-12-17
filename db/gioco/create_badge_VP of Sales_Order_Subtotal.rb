kind = Kind.find_or_create_by(name: 'Order_Subtotal')
badge = Badge.create({ 
                      :name => 'VP of Sales', 
                      :points => '500',
                      :kind_id  => kind.id,
                      :default => 'false',
                      :imgurl => 'trophy1.png'
                    })
puts '> Badge successfully created'