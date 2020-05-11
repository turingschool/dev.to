class AddMachineCollectionToTags < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_reference :tags, :machine_collection, foreign_key: true, index: {algorithm: :concurrently}
  end
end
