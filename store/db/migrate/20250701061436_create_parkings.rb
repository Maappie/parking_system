class CreateParkings < ActiveRecord::Migration[8.0]
  def change
    create_table :parkings do |t|
      t.string :car_model
      t.string :car_type
      t.string :plate_number
      t.boolean :available
      t.string :parking_number
      t.datetime :time_in
      t.datetime :time_out

      t.timestamps
    end
  end
end
