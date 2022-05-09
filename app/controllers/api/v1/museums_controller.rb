require 'json'
require 'open-uri'
module Api
  module V1
class MuseumsController < ApplicationController

  def index
    apiKey = ENV['MAPBOX_API_KEY']

    # url = "https://api.mapbox.com/geocoding/v5/mapbox.places/museum.json?proximity=-74.70850,40.78375&access_token=#{apiKey}"
    # url = "https://api.mapbox.com/geocoding/v5/mapbox.places/museum.json?lat=52.494857&lng=13.437641.json?access_token=#{apiKey}"
    url = "https://api.mapbox.com/geocoding/v5/mapbox.places/museum.json?proximity=#{params["lng"]},#{params["lat"]}&access_token=#{apiKey}"
    # url = "https://api.mapbox.com/geocoding/v5/mapbox.places/museum.json?type=poi&proximity=#{params["lng"]},#{params["lat"]}&access_token=#{apiKey}"
    museum_serialized = URI.open(url).read # serialized user is a string
    @museums = JSON.parse(museum_serialized)["features"]
    # museum_around = @museums.map do |museum|
    #   [museum["context"][0]["text"], museum["text"]]
    # end
    # museum_around = museum_around.group_by { |v| v[0] }
    # museum_around.transform_values! { |v| v.map { |iv| iv[1] } }

      results = {}
      @museums.each do |museum|
        code = museum["context"][0]["text"]
        if results.key?(code)
          results[code] << museum["text"]
        else
          results[code] = [museum["text"]]
        end
      end

      render json: results
      end
    end
  end
end
