class Sector < ActiveRecord::Base

  def self.all_alkp
    where('deleted is NULL or deleted = ?', false)
  end

  def self.destroy sector
    sector = Sector.find(sector.id)
    sector.update(deleted: true)
  end

end
