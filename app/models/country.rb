class Country < ActiveRecord::Base
  has_many :town, dependent: :destroy

  def self.all_alkp
    where('deleted is NULL or deleted = ?', false)
  end

  def self.destroy country
    country = Country.find(country.id)
    country.update(deleted: true)
  end

end
