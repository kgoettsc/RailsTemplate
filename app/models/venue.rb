class Venue < ActiveRecord::Base
  has_many :venue_activities
  has_many :activities, through: :venue_activities

  def coordinates
    [long, lat]
  end

  def activity_names
    activities.map(&:name)
  end

  def to_geojson
    properties_map = Activity::KINDS.inject({}) do |activity_map, activity|
      activity_map[activity] = activity_names.include?(activity)
      activity_map
    end
    properties_map["name"] = name
    properties_map["activities"] = activity_names

    {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": coordinates
      }
    }.merge("properties" => properties_map)
  end
end
