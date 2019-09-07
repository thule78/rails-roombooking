class AddGuestToReservation < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :guest, :integer
  end
end
