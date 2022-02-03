class CreateTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :topics do |t|
      t.string :name
      t.text :description
      t.string :api_key
      t.boolean :show_on_dashboard
      t.string :dashboard_name
      t.integer :dashboard_number_of_values
      t.integer :number_of_values_to_keep

      t.timestamps
    end
  end
end
