class CreateMachineCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :machine_collections do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.string :cached_tag_list
      t.string :slug
      t.timestamps
    end
  end
end
