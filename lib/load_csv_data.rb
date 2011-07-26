require 'CSV'
def load_csv_data
  Page.delete_all
  Program.delete_all
  Funder.delete_all
  Event.delete_all
  ActiveRecord::Base.connection.execute(
    "delete from tags; delete from taggings; delete from events_funders;")

  funder_names = %w( HNZ NSF BND FNE GGL BHL GRB PGH MCN SPR DOE AVD AUG BMB ).freeze
  CSV.read(File.join(RAILS_ROOT, 'db/programming_inventory.csv'))[2..-1].each do |fields|
    e = Event.new

    page = Page.find_or_create_by_name(fields[3].to_s.strip)
    e.page = page

    program = Program.find_or_create_by_name(fields[0].to_s.strip)
    page.program = program
    page.save!

    6.upto(19) do |idx|
      unless fields[idx].to_s.blank?
        e.funders << Funder.find_or_create_by_shortname(funder_names[idx-6])
      end
    end
    
    e.start_date    = (fields[4].to_s.blank? ? nil : Date.parse(fields[4].to_s))
    e.end_date      = (fields[5].to_s.blank? ? nil : Date.parse(fields[5].to_s))
    e.pre_school    = fields[22].to_i
    e.elementary    = fields[23].to_i
    e.middle_school = fields[24].to_i
    e.high_school   = fields[25].to_i
    e.adult         = fields[26].to_i
    e.comment       = fields[32].to_s

    e.organization_list          << fields[1].to_s unless fields[1].to_s.blank?
    e.location_list              << fields[2].to_s unless fields[2].to_s.blank?
    e.arena_list                 << fields[21].to_s unless fields[21].to_s.blank?
    e.geographic_scope_list      << fields[28].to_s unless fields[28].to_s.blank?
    e.connection_dialog_list     << fields[29].to_s unless fields[29].to_s.blank?
    e.collaborating_partner_list << fields[30].to_s unless fields[30].to_s.blank?
    e.affiliation_list           << fields[31].to_s unless fields[31].to_s.blank?
    e.theme_list                 << fields[33].to_s unless fields[33].to_s.blank?

    e.save!

  end
  
end
