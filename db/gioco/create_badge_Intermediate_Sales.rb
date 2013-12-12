kind = Kind.find_or_create_by(name: 'sales')
badge = Badge.create({ 
                      :name => 'intermediate', 
                      :points => '500',
                      :kind_id  => kind.id,
                      :default => 'false'
                    })
puts '> Badge successfully created'