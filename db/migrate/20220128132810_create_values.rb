class CreateValues < ActiveRecord::Migration[6.1]
  def change
    create_table :values do |t|
      t.integer :topic_id
      t.float :value
      t.date :measured_at#
      
      t.timestamps
    end
  end
end
