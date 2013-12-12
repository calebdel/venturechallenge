kind = Kind.find_or_create_by(name: 'Order_Count')
badge = Badge.create({ 
                      :name => 'Bakers Dozen', 
                      :points => '13',
                      :kind_id  => kind.id,
                      :default => 'false'
                    })
puts '> Badge successfully created'