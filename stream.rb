require 'tinder'
require 'slack-notifier'
require 'dotenv'
Dotenv.load

def listen_to_campfire
  notifier = Slack::Notifier.new ENV['SLACK_WEBHOOK_URL']

  campfire = Tinder::Campfire.new ENV['CAMPFIRE_SUBDOMAIN'], :token => ENV['CAMPFIRE_TOKEN']

  room = campfire.rooms.detect { |_room| _room.id.to_s == ENV['CAMPFIRE_ROOM'] }

  puts "Listening room #{room.name}"
  room.listen do |message|
    puts "Message #{message}"

    user = message.user

    if user && message.body
      ping_data = {
        username: user.name,
        icon_url: user.avatar_url
      }

      notifier.ping message.body.to_s, ping_data
    end
  end
rescue => e
  puts "I have failed!! #{e.message}"
  listen_to_campfire
end

listen_to_campfire
