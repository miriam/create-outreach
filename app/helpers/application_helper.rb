# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def current_user
    controller.current_user
  end

  def logged_in?
    controller.logged_in?
  end

  def themes
    find_tags("theme")
  end

  def affiliations
    find_tags("affiliation")
  end

  def collaborating_partners
    find_tags("collaborating_partners")
  end

  def connection_dialogs
    find_tags("connection_dialog")
  end

  def geographic_scopes
    find_tags("geographic_scope")
  end

  def arenas 
    find_tags("arena")
  end

  def locations 
    find_tags("location")
  end

  def organizations
    find_tags("organization")
  end

  private
  def find_tags(context)
    ActiveRecord::Base.connection.execute(
      "SELECT DISTINCT tags.name 
         FROM tags 
   INNER JOIN taggings ON taggings.tag_id = tags.id 
        WHERE taggings.context = '#{context}'"
    ).map {|t| t["name"] }

  end

end
