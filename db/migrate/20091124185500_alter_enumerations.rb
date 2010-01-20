class AlterEnumerations < ActiveRecord::Migration
  
  def self.up
   change_column :enumerations, :name, :string, :limit => 255, :default => '', :null => false
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
