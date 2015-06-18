class AddEmailToClient < ActiveRecord::Migration
  def change
    change_table :clients do |t|
      t.string :email
    end
  end
end
