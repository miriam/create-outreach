class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.column :id, :integer
      t.column :name, :text
      t.column :program_id, :integer
      t.column :description, :text
      t.column :published, :boolean

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
