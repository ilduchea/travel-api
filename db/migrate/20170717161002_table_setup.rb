class TableSetup < ActiveRecord::Migration[5.1]
  def change
    create_table :destinations do |t|
      t.column :name, :string
      t.column :city, :string
      t.column :locale, :string
      t.column :country, :string
    end

    create_table :reviews do |t|
      t.column :content, :string
      t.column :user_id, :integer
      t.column :destination_id, :integer
      t.column :heading, :string
      t.column :rating, :integer
    end

    create_table :users do |t|
      t.column :email, :string
      t.column :name, :string
      t.column :password_hash, :string
      t.column :password_salt, :string
    end
  end
end
