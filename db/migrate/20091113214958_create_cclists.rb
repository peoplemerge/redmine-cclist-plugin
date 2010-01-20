class CreateCclists < ActiveRecord::Migration
  def self.up
    create_table :cclists do |t|
      t.column :issue_id, :int
      t.column :email, :string
    end
  end

  def self.down
    drop_table :cclists
  end
end
