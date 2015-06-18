class Visa < ActiveRecord::Base

  def self.all_alkp
    where('deleted is NULL or deleted = ?', false)
  end

  def self.destroy visa
    visa = Visa.find(visa.id)
    visa.update(deleted: true)
  end

end
