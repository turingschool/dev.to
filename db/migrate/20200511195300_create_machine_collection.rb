class CreateMachineCollection < ActiveRecord::Migration[5.2]
  def change
    create_table :machine_collections do |t|
      t.string :title
      t.references :user

      t.timestamps
    end
  end
end
