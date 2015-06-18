class TypesPartner < ActiveRecord::Base

  def self.all_alkp
    where('deleted is NULL or deleted = ?', false)
  end

  def self.destroy types_partner
    types_partner = TypesPartner.find(types_partner.id)
    types_partner.update(deleted: true)
  end

end
