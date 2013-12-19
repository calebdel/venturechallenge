kind = Kind.find_or_create_by(name: 'Facebook')
badge = Badge.create({ 
                      :name => 'Facebook Referral', 
                      :points => '10',
                      :kind_id  => kind.id,
                      :default => 'false'
                    })
puts '> Badge successfully created'