kind = Kind.find_or_create_by(name: 'Instagram')
badge = Badge.create({ 
                      :name => 'Instagram Referral', 
                      :points => '10',
                      :kind_id  => kind.id,
                      :default => 'false'
                    })
puts '> Badge successfully created'