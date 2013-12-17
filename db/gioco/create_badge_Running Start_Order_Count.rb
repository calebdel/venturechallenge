kind = Kind.find_or_create_by(name: 'Order_Count')
badge = Badge.create({ 
                      :name => 'Running Start', 
                      :points => '2',
                      :kind_id  => kind.id,
                      :default => 'false',
                      :imgurl => 'trophy1.png'
                    })
puts '> Badge successfully created'