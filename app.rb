require 'sinatra'
require 'httparty'
require 'json'
 
post '/imfree' do
  postback params[:channel_id]
  status 200
end
 
def postback channel
    slack_webhook = ENV['SLACK_WEBHOOK_URL']
    HTTParty.post slack_webhook, body: {"text" => "Update your free time!\nhttps://docs.google.com/a/wearefuturegov.com/spreadsheets/d/1Hc_ktX_3XMAAbli0ZlV0VSI5pxxAEYJkWf4I_Zjc2vQ/edit?usp=sharing", "username" => "Freebot", "channel" => params[:channel_id]}.to_json, headers: {'content-type' => 'application/json'}
end