class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.integer :page_id
      t.integer :pre_school
      t.integer :elementary
      t.integer :middle_school
      t.integer :high_school
      t.integer :adult
      t.datetime :start_date
      t.datetime :end_date
      t.text :comment

      t.timestamps
    end

    create_table :event_fundings, :id => false do |t|
      t.integer :event_id
      t.integer :funder_id
    end
  end

  def self.down
    drop_table :events
  end
end
