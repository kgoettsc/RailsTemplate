class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.column :email, :string
      t.column :name, :name
      t.column :provider, :name
      t.column :uid, :string
      t.column :oauth_token, :string
      t.column :oauth_expires_at, :datetime
      t.timestamps
    end
  end
end
