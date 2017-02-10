require 'sinatra'
require 'httparty'
require 'json'
require 'api-ai-ruby'

 
post '/helpme' do
  # postback(params[:channel_id], params[:user_id], params[:user_name], params[:text])
  # "hi"
  # status 200
  logger.info JSON.parse(request.body.read.to_s)
end



# def api_ai_client
#   client = ApiAiRuby::Client.new(:client_access_token => ENV['1ad258b74e4a4654a7ff8f9bb086a3fc'])
# end
 
def postback(channel, user_id, user_name, text)
  # client = ApiAiRuby::Client.new(:client_access_token => ENV['1ad258b74e4a4654a7ff8f9bb086a3fc'])
  slack_webhook = ENV['SLACK_WEBHOOK_URL']   

  text = text.downcase 

  # graphic, service, strategy, organisation/business, product, development, tech, change, project mgmt, audio/video, finance, admin, data

  case text
    when "graphic"
      response ||= "Hey. <@#{user_name}> needs some help with some *graphic design.* Can you help, <@gaz>, <@willr>, <@ale>?"
    when "service"
      response ||= "Hey. <@#{user_name}> needs some help with some *service design.* Can you help, <@gaz>, <@willr>, <@ale>?"
    when "strategy"
      response ||= "Hey. <@#{user_name}> needs some help with some *strategy work.* Can you help, <@gaz>, <@willr>, <@ale>?"
    when "organisation"
      response ||= "Hey. <@#{user_name}> needs some help with some *org design.* Can you help, <@gaz>, <@willr>, <@ale>?"
    when "product"
      response ||= "Hey. <@#{user_name}> needs some help with some *product work.* Can you help, <@gaz>, <@willr>, <@ale>?"
    when "development"
      response ||= "Hey. <@#{user_name}> needs some help with some *development work.* Can you help, <@gaz>, <@willr>, <@ale>?"
    when "tech"
      response ||= "Hey. <@#{user_name}> needs some help with some *tech work.* Can you help, <@gaz>, <@willr>, <@ale>?"
    when "change"
      response ||= "Hey. <@#{user_name}> needs some help with some *change work.* Can you help, <@gaz>, <@willr>, <@ale>?"
    when "project mgmt"
      response ||= "Hey. <@#{user_name}> needs some help with some *project management work.* Can you help, <@gaz>, <@willr>, <@ale>?"
    when "audio/video"
      response ||= "Hey. <@#{user_name}> needs some help with some *audio/video work.* Can you help, <@gaz>, <@willr>, <@ale>?"
    when "finance"
      response ||= "Hey. <@#{user_name}> needs some help with some *finance work.* Can you help, <@gaz>, <@willr>, <@ale>?"
    when "admin"
      response ||= "Hey. <@#{user_name}> needs some help with some *admin.* Can you help, <@gaz>, <@willr>, <@ale>?"
    when "data"
      response ||= "Hey. <@#{user_name}> needs some help with some *data work.* Can you help, <@gaz>, <@willr>, <@ale>?"
    else
      response ||= "Sorry, but *#{text}* isn't in the list of categories I have. I'm not too smart so you'll need to enter a category from the list in the message pinned to this channel 😘"
  end


    HTTParty.post(slack_webhook, body: {
        "text" => response, 
        "username" => "Help Me Bot", 
        "channel" => params[:channel_id]}.to_json, 
        headers: {'content-type' => 'application/json'
      }
    )
end