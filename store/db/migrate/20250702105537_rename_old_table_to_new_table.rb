class RenameOldTableToNewTable < ActiveRecord::Migration[8.0]
  def change
      rename_table :cars, :accounts
  end
end
