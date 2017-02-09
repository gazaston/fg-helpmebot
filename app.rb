require 'sinatra'
require 'httparty'
require 'json'
 
post '/helpme' do
  postback(params[:channel_id], params[:user_id], params[:user_name], params[:text])
  status 200
end
 
def postback(channel, user_id, user_name, text)
    slack_webhook = ENV['SLACK_WEBHOOK_URL']    

  case text
    when "graphic"
      response ||= "Hey. <@#{user_name}> needs some help with some graphic design. Can you help, <@gaz>, <@willr>, <@ale>?"
    when "service"
      response ||= "Hey. <@#{user_name}> needs some help with some service design. Can you help, <@gaz>, <@willr>, <@ale>?"
    else
      response ||= "Sorry, I didn't get that…"
  end


    HTTParty.post(slack_webhook, body: {
        "text" => response, 
        "username" => "HelpMeBot", 
        "channel" => params[:channel_id]}.to_json, 
        headers: {'content-type' => 'application/json'
      }
    )
end