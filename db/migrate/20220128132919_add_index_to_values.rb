class AddIndexToValues < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!
  def change
    add_index :values, :topic_id, algorithm: :concurrently
  end
end
