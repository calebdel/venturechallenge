kind = Kind.find_or_create_by(name: 'Order_Subtotal')
badge = Badge.create({ 
                      :name => 'No Sales', 
                      :points => '0',
                      :kind_id  => kind.id,
                      :default => 'true',
                      :imgurl => 'customer1.png'
                    })
resources = Store.find(:all)
resources.each do |r|
        r.points  << Point.create({ :kind_id => kinds.id, :value => '0'})
          r.badges << badge
          r.save!
        end
puts '> Badge successfully created'