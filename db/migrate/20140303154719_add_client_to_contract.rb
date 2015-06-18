class AddClientToContract < ActiveRecord::Migration
  def change
    change_table :contracts do |t|
      t.references  :client, index: true
    end
  end
end
