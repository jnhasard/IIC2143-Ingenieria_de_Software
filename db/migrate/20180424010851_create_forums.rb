class CreateForums < ActiveRecord::Migration[5.1]
  def change
    create_table :forums do |t|
      t.string :title
      t.text :body
      t.string :fecha, default: Time.now.strftime("%m/%d/%Y")
      t.integer :visits_count, default: 0

      t.timestamps
    end
  end
end
