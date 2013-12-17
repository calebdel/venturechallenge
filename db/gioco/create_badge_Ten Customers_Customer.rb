kind = Kind.find_or_create_by(name: 'Customer')
badge = Badge.create({ 
                      :name => 'Ten Customers', 
                      :points => '200',
                      :kind_id  => kind.id,
                      :default => 'false'
                    })
puts '> Badge successfully created'