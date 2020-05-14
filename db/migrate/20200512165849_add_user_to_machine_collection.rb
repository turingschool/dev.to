class AddUserToMachineCollection < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_reference :machine_collections, :user, foreign_key: true, index: {algorithm: :concurrently}
  end
end
