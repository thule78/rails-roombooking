class RenamePhoneVerfied < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :phone_verfied, :phone_verified
  end
end
