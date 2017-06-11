class VenueService
  def self.to_geojson(venues)
    {
      "type": "FeatureCollection",
      "features": venues.map(&:to_geojson)
    }.to_json
  end
end
