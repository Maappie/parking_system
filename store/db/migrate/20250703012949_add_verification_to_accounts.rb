class AddVerificationToAccounts < ActiveRecord::Migration[8.0]
  def change
    add_column :accounts, :verification_code, :string
    add_column :accounts, :verified, :boolean, default: false
  end
end
