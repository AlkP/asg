class Town < ActiveRecord::Base
  belongs_to :country

  def self.all_alkp
    where('deleted is NULL or deleted = ?', false)
  end

  def self.destroy town
    town = Town.find(town.id)
    town.update(deleted: true)
  end

end
