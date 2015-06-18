class CreatePostDispatchEmails < ActiveRecord::Migration
  def change
    create_table :post_dispatch_emails do |t|
      t.string      :email

      t.references  :post_dispatch, index: true
      t.timestamps
    end
  end
end
