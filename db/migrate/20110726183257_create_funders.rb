class CreateFunders < ActiveRecord::Migration
  def self.up
    create_table :funders do |t|
      t.text :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :funders
  end
end
