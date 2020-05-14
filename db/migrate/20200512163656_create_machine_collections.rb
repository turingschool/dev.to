class CreateMachineCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :machine_collections do |t|
      t.string :title
    end
  end
end
