class Subscription < ActiveRecord::Migration[5.1]
  def change
  	create_table :forums_users, id: false do |t|
      t.belongs_to :users, index: true
      t.belongs_to :forums, index: true
    end
  end
end
