kind = Kind.find_or_create_by(name: 'sales')
badge = Badge.create({ 
                      :name => 'expert', 
                      :points => '700',
                      :kind_id  => kind.id,
                      :default => 'false'
                    })
puts '> Badge successfully created'