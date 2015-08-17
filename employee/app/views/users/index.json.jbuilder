json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :age, :salary, :department
  json.url user_url(user, format: :json)
end
