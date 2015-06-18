class CreatePostDispatches < ActiveRecord::Migration
  def change
    create_table :post_dispatches do |t|
      t.string  :subject
      t.text    :body
      t.string  :whom
      t.text    :list

      t.string  :periodicity
      t.string  :date
      t.time    :time

      t.timestamps
    end
  end
end
