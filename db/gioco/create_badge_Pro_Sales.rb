kind = Kind.find_or_create_by(name: 'Sales')
badge = Badge.create({ 
                      :name => 'Pro', 
                      :points => '2000',
                      :kind_id  => kind.id,
                      :default => 'false'
                    })
puts '> Badge successfully created'