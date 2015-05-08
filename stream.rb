require 'tinder'
require 'slack-notifier'
require 'dotenv'
Dotenv.load

def listen_to_campfire
  notifier = Slack::Notifier.new ENV['SLACK_WEBHOOK_URL']

  campfire = Tinder::Campfire.new ENV['CAMPFIRE_SUBDOMAIN'], :token => ENV['CAMPFIRE_TOKEN']

  room = campfire.rooms.detect { |_room| _room.id.to_s == ENV['CAMPFIRE_ROOM'] }

  room.listen do |message|
    user = message.user

    if user
      ping_data = {
        username: user.name,
        icon_url: user.avatar_url
      }
    else
      ping_data = {}
    end

    notifier.ping message.body.to_s, ping_data
  end
rescue => e
  puts "I have failed!! #{e.message}"
  listen_to_campfire
end

listen_to_campfire
