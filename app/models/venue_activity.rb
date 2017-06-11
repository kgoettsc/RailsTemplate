class VenueActivity < ActiveRecord::Base
  belongs_to :venue
  belongs_to :activity

  validates_uniqueness_of :venue_id, scope: :activity_id
end
