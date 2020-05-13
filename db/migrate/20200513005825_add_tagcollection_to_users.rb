class AddTagcollectionToUsers < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

   def change
     add_reference :users, :tagcollections, foreign_key: true, index: {algorithm: :concurrently}
   end
 end
