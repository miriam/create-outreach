class Page < ActiveRecord::Base
  has_many :events
  belongs_to :program
end
