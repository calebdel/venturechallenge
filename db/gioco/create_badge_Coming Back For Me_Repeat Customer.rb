kind = Kind.find_or_create_by(name: 'Repeat Customer')
badge = Badge.create({ 
                      :name => 'Coming Back For Me', 
                      :points => '2',
                      :kind_id  => kind.id,
                      :default => 'false',
                      :imgurl => 'trophy1.png'
                    })
puts '> Badge successfully created'