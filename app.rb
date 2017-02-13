require 'sinatra'
require 'httparty'
require 'json'
require 'api-ai-ruby'
require 'dotenv'
Dotenv.load

 
post '/helpme' do
  # logger.info JSON.parse(request.body.read.to_s)
  request.body.rewind  # in case someone already read it
  data = JSON.parse request.body.read
  responder(data)
end

def responder(data)
  user_name = data["originalRequest"]["data"]["user"].to_s
  case data["result"]["parameters"]["discipline"]
    when "graphic"
      response ||= "Hey. <@#{user_name}> needs some help with some *graphic design.* Can you help, <@ale>, <@kj>, <@elle>, <@nina>, <@chris>, <@gaz>, <@dessy>?"
    when "service"
      response ||= "Hey. <@#{user_name}> needs some help with some *service design.* Can you help, <@ale>, <@kj>, <@elle>, <@lingjing>, <@nina>, <@emilybazalgette>, <@simone>, <@jan>, <@dessy>?"
    when "strategy"
      response ||= "Hey. <@#{user_name}> needs some help with some *strategy work.* Can you help, <@ale>, <@kj>, <@elle>, <@lingjing>, <@nina>, <@emilybazalgette>, <@adam>, <@simone>, <@jrae>, <@alex>, <@emmamcg>, <@benunsworth>, <@willr>, <@matt>?"
    when "organisation"
      response ||= "Hey. <@#{user_name}> needs some help with some *org design.* Can you help, <@lingjing>, <@nina>, <@emilybazalgette>, <@adam>, <@simone>, <@emmamcg>, <@benunsworth>?"
    when "product"
      response ||= "Hey. <@#{user_name}> needs some help with some *product work.* Can you help, <@kj>, <@elle>, <@lingjing>, <@chris>, <@gaz>, <@jrae>, <@alex>, <@matt>, <@dessy>?"
    when "development"
      response ||= "Hey. <@#{user_name}> needs some help with some *development work.* Can you help, <@chris>, <@gaz>, <@jrae>, <@alex>?"
    when "tech"
      response ||= "Hey. <@#{user_name}> needs some help with some *tech work.* Can you help, <@chris>, <@gaz>, <@jrae>, <@alex>, <@benunsworth>, <@willr>, <@matt>?"
    when "change"
      response ||= "Hey. <@#{user_name}> needs some help with some *change work.* Can you help, <@nina>, <@emilybazalgette>, <@adam>, <@alex>, <@benunsworth>?"
    when "project mgmt"
      response ||= "Hey. <@#{user_name}> needs some help with some *project management work.* Can you help, <@nina>, <@emilybazalgette>, <@adam>, <@alex>, <@benunsworth>?"
    when "audio/video"
      response ||= "Hey. <@#{user_name}> needs some help with some *audio/video work.* Can you help, <@elle>, <@chris>, <@gaz>?"
    when "finance"
      response ||= "Hey. <@#{user_name}> needs some help with some *finance work.* Can you help, <@roberta>, <@matt>?"
    when "admin"
      response ||= "Hey. <@#{user_name}> needs some help with some *admin.* Can you help, <@roberta>, <@oana>?"
    when "data"
      response ||= "Hey. <@#{user_name}> needs some help with some *data work.* Can you help, <@nina>, <@adam>, <@gaz>, <@benunsworth>?"
    when "writing"
      response ||= "Hey. <@#{user_name}> needs some help with some *writing/editing work.* Can you help, <@nina>, <@adam>, <@gaz>, <@benunsworth>?"
    when "test"
      response ||= "Hey. This is just a test response."
    else
      response ||= "Sorry, but that isn't in the list of categories I have. I'm not too smart so you'll need to enter a category from the list in the message pinned to this channel 😘"
  end
  content_type :json
  {
    "speech" => response,
    "displayText" => response,
    "data" => {
      "slack" => {
        "text" => response,
        "attachments" => [
          {
            # "text" => "And here's an attachment!!",
            "fallback" => "Help!",
            "color" => "#1072ae",
            "footer" => "Won't you please, please help me?",
            "footer_icon" => "https://d3uepj124s5rcx.cloudfront.net/items/403t421f0U1d0B2R111c/Lennon.jpg"
          }
        ]
      }
    },
    headers: {'content-type' => 'application/json'}
  }.to_json
end