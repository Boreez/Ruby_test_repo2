require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'


get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"
end

get '/about' do
	erb :about
end

get '/contacts' do
	erb :contacts
end

post '/contacts' do
require 'pony'
Pony.mail(
  #:body => params[:body],
  :to => 'etest527@gmail.com',
  :subject => "BarberShop received message from #{params[:name]} <#{params[:email]}> ",
	:body => "#{params[:message]} \n\n Click here to reply #{params[:name]}: <#{params[:email]}> ",
	#:port => '587',
	:via => :smtp,
  :via_options => {
    :address              => 'smtp.gmail.com',
    :port                 => '587',
    :enable_starttls_auto => true,
    :user_name            => 'etest527',
    :password             => 't3stt3st',
    :authentication       => :plain,
    :domain               => 'localhost.localdomain'
  								}
)
redirect '/success'
end

get '/success' do
	erb :success
end


get '/visit' do
	erb :visit
end

post '/visit' do

	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@barber = params[:barber]
	@color = params[:color]
#First way
# if @username == ''
#	@errors
#end
# and than for all values or variables in form

#Second way: use hash
	# хеш
	hh = { 	:username => 'Введите имя',
			:phone => 'Введите телефон',
			:datetime => 'Введите дату и время' }

	@error = hh.select {|key,_| params[key] == ""}.values.join(", ")

	if @error != ''
		return erb :visit
	end

	erb "OK, username is #{@username}, #{@phone}, #{@datetime}, #{@barber}, #{@color}"

end
