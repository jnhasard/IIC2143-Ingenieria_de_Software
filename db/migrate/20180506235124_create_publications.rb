class CreatePublications < ActiveRecord::Migration[5.1]
  def change
    create_table :publications do |t|
      t.string :title
      t.text :body
      t.string :tipo
      t.integer :visits_count

      t.timestamps
    end
  end
end
