kind = Kind.find_or_create_by(name: 'Customer')
badge = Badge.create({ 
                      :name => '15 Customers', 
                      :points => '150',
                      :kind_id  => kind.id,
                      :default => 'false'
                    })
puts '> Badge successfully created'