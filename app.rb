require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?


get '/' do
  erb :index
end

post '/pic' do
  picPath = "public/images/base.jpg"
  image = params[:pic][:tempfile]
  open(picPath, 'wb') do |output|
    open(image) do |data|
      output.write(data.read)
      base = Magick::Image.read(picPath).first
      base = base.edge(50)
      base.write("public/images/result.jpg")
    end
  end
  send_file("public/images/result.jpg")
end