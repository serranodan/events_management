class CreateEventPlaces < ActiveRecord::Migration[7.1]
  def change
    create_table :event_places do |t|
      t.string :name
      t.string :location

      t.references :created_by
      t.timestamps
    end

    create_table :reservations do |t|
      t.references  :event_place
      t.references  :reserved_by

      t.datetime    :start_time
      t.datetime    :end_time

      t.timestamps
    end
  end
end
