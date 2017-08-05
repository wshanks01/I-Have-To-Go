class CreateBathrooms < ActiveRecord::Migration[5.0]
  def change
    create_table :bathrooms do |t|
      t.string :name
      t.string :description
      t.float :lat
      t.float :long
      t.string :address
      t.string :wheelchair
      t.string :childfriendly

      t.timestamps
    end
  end
end
