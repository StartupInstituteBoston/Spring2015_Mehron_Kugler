class Restaurant < ActiveRecord::Base
  validates :name, presence: true

  def googlemaps_url(escaped_address, venue)
    mapwidth = 250
    mapheight = 250
    zoomlevel = 14
    center = escaped_address
    markertitle = venue.name.gsub(/ /, '+')
    markercenter = escaped_address
    markersize = "mid"
    maptype = "roadmap"
    regular_url = ("https://maps.googleapis.com/maps/api/staticmap?center=" + escaped_address +
    "&zoom=" + zoomlevel.to_s +
    "&size=" + mapwidth.to_s + "x" + mapheight.to_s +
    "&maptype=roadmap" +
    "&markers=size:mid%7Ccolor:red%7Clabel:A%7C" + escaped_address
    )
    return (regular_url)
  end
end
