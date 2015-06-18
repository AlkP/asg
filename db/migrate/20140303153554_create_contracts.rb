class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string      :name
      t.string      :number
      t.date        :date
      t.float       :amount
      t.boolean     :annex

      t.references  :template, index: true

      t.timestamps
    end
  end
end
