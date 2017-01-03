require 'active_record'
require 'sinatra'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'fog'
require 'pry'

require_relative 'db_config'
require_relative 'models/follower'
require_relative 'models/image'
require_relative 'models/location'
require_relative 'models/route'
require_relative 'models/user'
require_relative 'models/vote'
require_relative 'models/step'

enable :sessions

helpers do
  def logged_in?
    !!current_user
  end

  def current_user
    if User.find_by(id: session[:user_id])
      User.find_by(id: session[:user_id])
    else
      nil
    end
  end

end

get '/' do
  # if current user and kickem out if not loggied in - redirect to location or error message
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
  @new_loc.user_id = session[:user_id]

  if @new_loc.save
    redirect to '/'
  else
    erb :location_new
  end
end

post '/locations/search' do
  @results = Location.where(name: params[:location])
  #can add in the case insensitive thing
  # jquery plugin
erb :search_results
end

#show locations page
get '/locations/:locationid' do
  @location = Location.find(params[:locationid])
  @name = @location.name
  @routes = @location.routes

  @routelist = {};

  @routes.each do |route|
    @votes = route.votes.count
    @title = route.title
    @id = route.id
    @routelist["#{@title}"] = ["#{@votes}","#{@id}"]
  end

  @orderedlist = @routelist.sort_by {|key, value| value[0]}.reverse

  erb :location
end

#create new route entry
#this should link from the unique location page
get "/locations/:locationid/new" do
  @locid = params[:locationid]

  erb :route_new
end

#post new route
post '/locations/:locationid' do
  @new_route = Route.new
  @new_route.title = params[:title]
  @new_route.location_id = params[:locationid]
  @new_route.date_authored = Time.now.strftime("%Y-%m-%d")
  @new_route.description = params[:description]
  @new_route.author_id = session[:user_id]
  @new_route.img = params[:img]

  if @new_route.save
    redirect to "/locations/#{@new_route.location_id}/#{@new_route.id}"
  else
    erb :route_new
  end
end

#show routes page
get '/locations/:locationid/:routeid' do
  @route = Route.where('id = ? AND location_id = ?', params[:routeid], params[:locationid])[0]
  @date = @route.date_authored
  @title = @route.title
  @description = @route.description
  @votes = @route.votes.count
  @author_id = User.find(@route.author_id).username
  @img = @route.img

  erb :route
end

#vote
post '/locations/:locationid/:routeid/bump' do
  @locid = params[:locationid]
  @routeid = params[:routeid]

  @newvote = Vote.new
  @newvote.user_id = session[:user_id]
  @newvote.route_id = @routeid
  if Vote.where('user_id = ? AND route_id = ?', session[:user_id], @routeid)[0] != nil
    # if current_user.canVote(route)
    @msg = "you can't vote again"
    redirect to "/locations/#{@locid}/#{@routeid}"
  else
    @newvote.save
    redirect to "/locations/#{@locid}/#{@routeid}"
  end
end


#anything with ID should be below anything with word

#show edit route form
get '/locations/:locationid/:routeid/edit' do
  @route = Route.where('id = ? AND location_id = ?', params[:routeid], params[:locationid])[0]

  erb :route_edit
end

#update route
post '/locations/:locationid/:routeid' do
  @routeid = params[:routeid]
  @locid = params[:locationid]
  @route = Route.where('id = ? AND location_id = ?', @routeid, @locid)[0]

  @route.update(title: params[:title], date_authored: Time.now.strftime("%Y-%m-%d"), description: params[:description], img: params[:img])

  redirect to "/locations/#{@locid}/#{@routeid}"
end

#delete route
post '/locations/:locationid/:routeid/delete' do
  @route = Route.where('id = ? AND location_id = ?', params[:routeid], params[:locationid])[0]
  @route.destroy

  redirect to "/locations/#{params[:location_id]}"
end

#new session
get '/session/new' do

  erb :session_new
end

post '/session' do
  @user = User.find_by(username: params[:username])

  if @user && @user.authenticate(params[:password])
    #u are fine, lemme create a session for u
    session[:user_id] = @user.id

    redirect to '/'
  else #whoaare you
    erb :session_new
  end
end

get '/register' do

  erb :register
end

post '/register' do
  user = User.new
  user.email = params[:email]
  user.username = params[:username]
  user.password = params[:password]
  if User.find_by(username: params[:username]) != nil
    @msg = "username already taken pls pick another one"
    # use validations to do this sort of stuff!!
    # User.errors
    # @error_message = User.errors[:passwor_too_short]
    erb :register
  elsif User.find_by(email: params[:email]) != nil
    @msg = "email already in use"
    erb :register
  else user.save
      redirect to '/session/new'
  end
end

delete '/session' do
  session[:user_id] = nil
  #remove the session
  redirect to '/session/new'
end
