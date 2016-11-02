require 'active_record'
require 'sinatra'
require 'sinatra/reloader'

require_relative 'db_config'
require_relative 'models/follower'
require_relative 'models/image'
require_relative 'models/location'
require_relative 'models/route'
require_relative 'models/user'
require_relative 'models/vote'
require_relative 'models/step'

require 'pry'

get '/' do
  #display three random location's most popular route's img
  @randLocations = Location.order("RANDOM()")

  erb :index
end

#create new location request
#this should link from a search results page
get '/locations/new' do
  @locations = Location.all

  erb :location_new
end

#save new location entry
post '/locations' do
  @new_loc = Location.new
  @new_loc.name = params[:location]

  @new_loc.user_id = User.all.find_by(username: "#{params[:username]}").id

  if @new_loc.save
    redirect to '/'
  else erb :location_new
  end
#need new and save here

end
#show locations page
get '/locations/:id' do
  @location = Location.find(params[:id])
  @name = @location.name
  @routes = @location.routes

  erb :location
end

#create new route entry
#this should link from the unique location page
get "/locations/:id/new" do

  erb :route_new
end

#post new route
post '/locations/:id' do
  @new_route = Route.new
  @new_route.title = params[:title]
  @new_route.location_id = Location.find(params[:id])
  @new_route.date_authored = Time.now.strftime("%Y-%m-%d")
  @new_route.description = params[:description]
  @new_route.author_id = User.all.find_by(username: "#{params[:username]}").id
  @new_route.img = params[:img]
  # @new_route.votes = 0

  if @new_route.save
    redirect to "/locations/#{@new_route.location_id}/#{@new_route.id}"
  else erb :route_new
  end
end

#show routes page
get '/locations/:name/:id' do
  @location = Location.find(params[:id])
  @loc_id = params[:id]
  @route = Route.where('id = ? AND location_id = ?', params[:id], @location.id)[0]
  @date = @route.date_authored
  @title = @route.title
  @description = @route.description
  @votes = @route.votes
  @author_id = @route.author_id

  erb :route
end

#anything with ID should be below anything with word

#show edit route form
get '/locations/:name/:id/edit' do

  erb :edit_route
end


post '/locations/:name/:id' do

  redirect to '/'
end
