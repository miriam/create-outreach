class Event < ActiveRecord::Base
  belongs_to :page
  has_and_belongs_to_many :funders
  acts_as_taggable_on :organization, :location, :arena, :geographic_scope, 
    :connection_dialog, :collaborating_partner, :affiliation, :theme

  def total_participants
    pre_school + elementary + middle_school + high_school + adult 
  end

  def organization=(value)
    value.each do |v|
      self.organization_list << v unless v.blank?
    end
  end

  def location=(value)
    value.each do |v|
      self.location_list << v unless v.blank?
    end
  end

  def arena=(value)
    value.each do |v|
      self.arena_list << v unless v.blank?
    end
  end

  def geographic_scope=(value)
    value.each do |v|
      self.geographic_scope_list << v unless v.blank?
    end
  end

  def connection_dialog=(value)
    value.each do |v|
      self.connection_dialog_list << v unless v.blank?
    end
  end

  def collaborating_partner=(value)
    value.each do |v|
      self.collaborating_partner_list << v unless v.blank?
    end
  end

  def affiliation=(value)
    value.each do |v|
      self.affiliation_list << v unless v.blank?
    end
  end

  def theme=(value)
    value.each do |v|
      self.theme_list << v unless v.blank?
    end
  end

end
