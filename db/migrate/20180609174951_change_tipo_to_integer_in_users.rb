class ChangeTipoToIntegerInUsers < ActiveRecord::Migration[5.1]
  def change
  	remove_column :users, :tipo
  	add_column :users, :tipo, :integer, :default => 1
  end
end
