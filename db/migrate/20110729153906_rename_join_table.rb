class RenameJoinTable < ActiveRecord::Migration
  def self.up
    rename_table :event_fundings, :events_funders
  end

  def self.down
    rename_table :events_funders, :event_fundings
  end
end
