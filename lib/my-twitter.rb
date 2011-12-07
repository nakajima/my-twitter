require "rubygems"
require "twitter"
require "my-twitter/version"

module My
  module Twitter
    extend self

    def client
      @client ||= ::Twitter::Client.new(config)
    end

    def config
      prompt unless File.exists?(config_file)
      config = File.read(config_file).split("\n")
      {
        :consumer_key       => config[0],
        :consumer_secret    => config[1],
        :oauth_token        => config[2],
        :oauth_token_secret => config[3]
      }
    end

    def prompt
      credentials = []
      puts "Enter your consumer key"
      credentials << $stdin.gets.chomp
      puts "Enter your consumer secret"
      credentials << $stdin.gets.chomp
      puts "Enter your access token"
      credentials << $stdin.gets.chomp
      puts "Enter your access token secret"
      credentials << $stdin.gets.chomp
      File.open(config_file, "w+") do |f|
        f.puts credentials.join("\n")
      end
    end

    private

    def config_file
      File.join(ENV["HOME"], ".mytwitter")
    end
  end
end
