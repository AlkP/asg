class User < ActiveRecord::Base
  has_many :event, dependent: :destroy
  #attr_accessible :email, :password, :password_confirmation, :admin
  has_secure_password
  validates_presence_of :email
  validates_uniqueness_of :email

  def self.all_alkp
    where('deleted is NULL or deleted = ?',false)
  end

  def self.destroy user
    user = User.find(user.id)
    user.update(deleted: true)
  end

end
