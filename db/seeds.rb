User.create(username: 'Anson', email: 'hianson@gmail.com', password_digest: 'anson')

corners_store = Bathroom.create(location_name: "Corner's Store", latitude: 37.785546, longitude: -122.396981, over_21: true, handicapped: false, family: false, customer_only: true)

5.times do
  corners_store.reviews.create(ratings: rand(1..5), description: Faker::Lorem.paragraph, user_id: User.first.id )
end

7.times do |i|
  corners_store.time_frames.create(day: i, is_overnight: false, start: '0001', close: '2358')
end

i = 0
10.times do
  response = HTTParty.get("https://api.yelp.com/v3/businesses/search?location=sanfrancisco&attributes=gender_neutral_restrooms&offset=#{i}", headers: {Authorization: "Bearer dBIo5uV7Nn-Dl9CV2AzSjZ6SA3DE0KneUI_wwdOtRN8P7NnoDcbjKeSMBrKTg8b8nsQO0brYUl-v8n3DSAEtNu1sqWxcbErMekhbtXTMpo-e6CbFSLqXwDte5orrWXYx"} )

  businesses = JSON.parse(response.body)

  ids = []

  businesses["businesses"].each do |business|
    bathroom = Bathroom.create(location_name: business["name"], latitude: business["coordinates"]["latitude"], longitude: business["coordinates"]["longitude"])
    ids << { yelp_id: business["id"], db_id: bathroom.id }
  end

  ids.each do |id|
    bathroom = Bathroom.find_by(id: id[:db_id])
    response = HTTParty.get("https://api.yelp.com/v3/businesses/#{URI.encode(id[:yelp_id])}", headers: {Authorization: "Bearer dBIo5uV7Nn-Dl9CV2AzSjZ6SA3DE0KneUI_wwdOtRN8P7NnoDcbjKeSMBrKTg8b8nsQO0brYUl-v8n3DSAEtNu1sqWxcbErMekhbtXTMpo-e6CbFSLqXwDte5orrWXYx"} )
    business =  JSON.parse(response.body)
    if business["hours"]
      business["hours"][0]["open"].each do |open|
        bathroom.time_frames.create(day: open["day"], is_overnight: open["is_overnight"], start: open["start"].to_s, close: open["end"].to_s)
      end
    end
  end
  i += 20
end
