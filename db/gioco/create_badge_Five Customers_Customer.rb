kind = Kind.find_or_create_by(name: 'Customer')
badge = Badge.create({ 
                      :name => 'Five Customers', 
                      :points => '25',
                      :kind_id  => kind.id,
                      :default => 'false',
                      :imgurl => 'customer1.png'
                    })
puts '> Badge successfully created'