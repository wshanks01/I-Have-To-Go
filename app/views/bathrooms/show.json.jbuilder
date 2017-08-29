json.bathroom do |json, bathroom |
  json.(@bathroom,:id, :name, :description, :lat, :long, :address, :wheelchair, :childfriendly)
  json.ratings @bathroom.ratings_total
end