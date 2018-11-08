class AddUserIdToPublications < ActiveRecord::Migration[5.1]
  def change
    add_reference :publications, :user, index: true  # foreign_key: true,
    add_foreign_key :publications, :users # esto se lo agregué
  end
end
