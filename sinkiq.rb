require 'sinatra'
require 'sidekiq'

class SinatraWorker
  include Sidekiq::Worker

  def perform
    (1..100).each { |number| p number; sleep 0.3 }
  end
end

get '/' do
  "<h3>Press the button to start Sidekiq</h3>" +
  "<form action='/message' method='post'>" +
    "<button type='submit'>Start</button>" +
  "</form>"
end

post '/message' do
  SinatraWorker.perform_async
  "<h1>Sidekiq is making the job</h1>"
end