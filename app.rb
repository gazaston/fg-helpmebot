require 'sinatra'
require 'httparty'
require 'json'
 
post '/helpme' do
  postback params[:channel_id]
  status 200
end
 
def postback(channel, user)
    slack_webhook = ENV['SLACK_WEBHOOK_URL']
    
    # if discipline = ""


    HTTParty.post(slack_webhook, body: {
        "text" => "hey #{user}", 
        "username" => "Freebot", 
        "channel" => params[:channel_id]}.to_json, 
        headers: {'content-type' => 'application/json'
      }
    )
end