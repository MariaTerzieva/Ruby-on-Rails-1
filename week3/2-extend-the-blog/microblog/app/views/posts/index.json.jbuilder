json.array!(@posts) do |post|
  json.extract! post, :id, :body, :title
  json.url post_url(post, format: :json)
end
