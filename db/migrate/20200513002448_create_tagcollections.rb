class CreateTagcollections < ActiveRecord::Migration[5.2]
  def change
    create_table :tagcollections do |t|
      t.string :name
    end
  end
end
