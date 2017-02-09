require 'sinatra'
require 'httparty'
require 'json'
 
post '/helpme' do
  postback(params[:channel_id], params[:user_id], params[:user_name], params[:text])
  status 200
end
 
def postback(channel, user_id, user_name, text)
    slack_webhook = ENV['SLACK_WEBHOOK_URL']
    
    # if discipline = ""


    HTTParty.post(slack_webhook, body: {
        "text" => "Hey. <@#{user_name}> needs some help with #{text}", 
        "username" => user_name, 
        "channel" => params[:channel_id]}.to_json, 
        headers: {'content-type' => 'application/json'
      }
    )
end