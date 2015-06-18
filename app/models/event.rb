class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :client
  belongs_to :staff
  belongs_to :tour
  belongs_to :partner

end
