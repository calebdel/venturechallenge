kind = Kind.find_or_create_by(name: 'Sales')
badge = Badge.create({ 
                      :name => 'Intermediate', 
                      :points => '500',
                      :kind_id  => kind.id,
                      :default => 'false'
                    })
puts '> Badge successfully created'