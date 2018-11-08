class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.references :publication, foreign_key: true
      t.text :body
      t.integer :visits_count

      t.timestamps
    end
  end
end
