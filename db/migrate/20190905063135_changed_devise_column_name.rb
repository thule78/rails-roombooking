class ChangedDeviseColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :comfirmation_sent_at, :confirmation_sent_at
  end
end
