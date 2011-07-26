class AddShortnameToFunders < ActiveRecord::Migration
  def self.up
    add_column "funders", "shortname", :string
  end

  def self.down
    remove_column "funders", "shortname"
  end
end
