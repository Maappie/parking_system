class CreateCars < ActiveRecord::Migration[8.0]
  def change
    create_table :cars do |t|
      t.string :car_model
      t.string :car_type
      t.string :plate_number
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
