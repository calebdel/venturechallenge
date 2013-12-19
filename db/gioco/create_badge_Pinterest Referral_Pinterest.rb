kind = Kind.find_or_create_by(name: 'Pinterest')
badge = Badge.create({ 
                      :name => 'Pinterest Referral', 
                      :points => '10',
                      :kind_id  => kind.id,
                      :default => 'false'
                    })
puts '> Badge successfully created'