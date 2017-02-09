require 'sinatra'
require 'httparty'
require 'json'
 
post '/helpme' do
  postback(params[:channel_id], params[:user_id], , params[:user_name])
  status 200
end
 
def postback(channel, user_id, user_name)
    slack_webhook = ENV['SLACK_WEBHOOK_URL']
    
    # if discipline = ""


    HTTParty.post(slack_webhook, body: {
        "text" => "hey #{user_name}", 
        "username" => user_name, 
        "channel" => params[:channel_id]}.to_json, 
        headers: {'content-type' => 'application/json'
      }
    )
end