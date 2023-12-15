class AddStatusToReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :status, :string, default: "pending"

    add_index :reservations, :status
  end
end
