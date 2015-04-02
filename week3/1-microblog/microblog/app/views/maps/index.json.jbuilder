json.array!(@maps) do |map|
  json.extract! map, :id, :post_id, :tag_id
  json.url map_url(map, format: :json)
end
