kind = Kind.find_or_create_by(name: 'Orders_today')
badge = Badge.create({ 
                      :name => '5 in a Day', 
                      :points => '5',
                      :kind_id  => kind.id,
                      :default => 'false'
                    })
puts '> Badge successfully created'