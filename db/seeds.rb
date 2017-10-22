i = 0
5.times do
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
    business["hours"][0]["open"].each do |open|
      bathroom.time_frames.create(day: open["day"], is_overnight: open["is_overnight"], start: open["start"].to_s, close: open["end"].to_s)
    end
  end
  i += 20
end
