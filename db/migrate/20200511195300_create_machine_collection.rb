class CreateMachineCollection < ActiveRecord::Migration[5.2]
  def change
    create_table :machine_collections do |t|
      t.string :title
      t.references :user, index: { unique: true }
      t.references :tags

      t.timestamps
    end
  end
end
