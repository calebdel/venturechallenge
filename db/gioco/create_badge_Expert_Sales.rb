kind = Kind.find_or_create_by(name: 'Sales')
badge = Badge.create({ 
                      :name => 'Expert', 
                      :points => '1000',
                      :kind_id  => kind.id,
                      :default => 'false'
                    })
puts '> Badge successfully created'