class Partner < ActiveRecord::Base

  has_many :tour_room, dependent: :destroy
  has_many :event, dependent: :destroy

  def self.all_alkp
    where('deleted is NULL or deleted = ?', false)
  end

  def self.destroy partner
    partner = Partner.find(partner.id)
    partner.update(deleted: true)
  end

end
