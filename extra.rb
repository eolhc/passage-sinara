get '/locations/:id' do
  @location = Location.find(params[:id])
  @name = @location.name
  @routes = @location.routes

  erb :location
end

<h2> <%= @name %> </h2>
  <ol>
    <% @routes.each do |route| %>
      <li><a href="/locations/<%= params[:id] %>/<%= route.id %>"><%= route.title %></a></li>
    <% end %>
  </ol>
</table>
