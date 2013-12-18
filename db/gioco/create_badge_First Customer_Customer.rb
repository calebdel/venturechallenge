kind = Kind.find_or_create_by(name: 'Customer')
badge = Badge.create({ 
                      :name => 'First Customer', 
                      :points => '11',
                      :kind_id  => kind.id,
                      :default => 'false'
                    })
puts '> Badge successfully created'