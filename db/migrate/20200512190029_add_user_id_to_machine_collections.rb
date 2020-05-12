class AddUserIdToMachineCollections < ActiveRecord::Migration[5.2]
  def change
    def change
      add_column :machine_collections, :user, :integer
      add_index  :machine_collections, :user
    end
  end
end
