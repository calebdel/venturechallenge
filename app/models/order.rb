class Order < ActiveRecord::Base
	belongs_to :store

  before_save :truncate_values
  def truncate_values
    self.referring_site = self.referring_site[0..99] if self.referring_site.length > 100
  end

end
