kind = Kind.find_or_create_by(name: 'Website_Referral')
badge = Badge.create({ 
                      :name => 'Well Connected', 
                      :points => '2',
                      :kind_id  => kind.id,
                      :default => 'false',
                      :imgurl => 'trophy1.png'
                    })
puts '> Badge successfully created'