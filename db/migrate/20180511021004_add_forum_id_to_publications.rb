class AddForumIdToPublications < ActiveRecord::Migration[5.1]
  def change
    add_reference :publications, :forum, index: true  # foreign_key: true,
    add_foreign_key :publications, :forums # esto se lo agregué
  end
end
