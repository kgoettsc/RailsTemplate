class VenueFinder
  def self.by_activities(activities, location)
    activities.each do |activity|
      by_activity(activity, location)
    end
  end

  def self.by_activity(activity_name, location)
    activity = Activity.find_or_create_by(name: activity_name)

    response = FoursquareService.venues_explore(activity_name, location).with_indifferent_access
    venue_infos = response[:groups].flat_map{|g| g[:items] }

    venues = venue_infos.map do |info|
      venue_info = info[:venue]

      external_id, name = venue_info.slice(:id, :name).values
      lat, long = venue_info[:location].slice(:lat, :lng).values

      venue = Venue.find_or_initialize_by(external_id: external_id)
      venue.assign_attributes(name: name, lat: lat, long: long)
      venue.save!

      activity.venues << venue

      venue
    end
  end
end
