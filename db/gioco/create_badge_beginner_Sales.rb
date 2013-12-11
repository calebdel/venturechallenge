kind = Kind.find_or_create_by(name: 'Sales')
badge = Badge.create({ 
                      :name => 'Beginner', 
                      :points => '100',
                      :kind_id  => kind.id,
                      :default => 'false'
                    })
puts '> Badge successfully created'