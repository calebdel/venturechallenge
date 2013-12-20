kind = Kind.find_or_create_by(name: 'Twitter')
badge = Badge.create({ 
                      :name => 'Twitter Referral', 
                      :points => '10',
                      :kind_id  => kind.id,
                      :default => 'false'
                    })
puts '> Badge successfully created'