class FoursquareService
  include HTTParty

  def self.venues_explore(query, location)
    puts "Querying: #{query}"
    fs_get(full_url("/venues/explore"), query: query, near: location)["response"]
  end

  def self.fs_get(url, options)
    options.merge!({client_id: ENV['FS_CLIENT_ID'], client_secret: ENV['FS_CLIENT_SECRET'], v: "20170601"})

    JSON.parse(get(url, query: options).body)
  end

  def self.full_url(path)
    "#{ENV['FS_URL']}#{path}"
  end
end
