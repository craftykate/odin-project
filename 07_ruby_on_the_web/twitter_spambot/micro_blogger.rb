require 'jumpstart_auth'
require 'bitly'

class MicroBlogger
	attr_reader :client

	def initialize
		puts "Initializing..."
		@client = JumpstartAuth.twitter
	end

	# Get command from user
	def run
		puts "Welcome to the JSL Twitter Client!"
		command = ""
		while command != "q"
			puts "Options:"
			puts "q: to quit"
			puts "t Message: to tweet"
			puts "turl Message with http://: tweet and shorten url"
			puts "dm Friend Message: to send a private message"
			puts "spam Message: to send a message to all friends"
			puts "elt: see all friends last tweets"
			puts "s url: shorten url"
			printf "enter command: "
			input = gets.chomp
			parts = input.split(" ")
			# Command is first part of input, so isolate it 
			command = parts[0]
			case command
			  when 'q' then puts "Goodbye!"
			  when 't' then tweet(parts[1..-1].join(" "))
			  when 'turl' then tweet_url(parts[1..-1])
			  when 'dm' then dm(parts[1], parts[2..-1].join(" "))
			  when 'spam' then spam_my_followers(parts[1..-1].join(" "))
			  when 'elt' then everyones_last_tweet
			  when 's' then puts shorten(parts[1]) 
			  else
			  	puts "Sorry, I don't know how to #{command}"
			 end
		end
	end

	# Tweet a message
	def tweet(message)
		if message.length <= 140
			@client.update(message)
		else
			puts "Oops, your message is too long!"
		end
	end

	# Tweet a message containing a url
	# This goes one step further than Jumpstart's instructions:
	# It finds any url in the message wherever it is and shortens it
	# So the url could be in the beginning or the middle etc.
	# ALL url's will be shortened
	def tweet_url(message)
		short_tweet = []
		# Go through each wprd in message...
		message.each do |word|
			# If the word is a url...
			if word[0..6] == "http://"
				# Shorten it and store the shortened word
				short_url = shorten(word)
				short_tweet << short_url
			else
				# Word isn't a url, so just store it
				short_tweet << word
			end
		end
		# Tweet the new message with short url's
		tweet(short_tweet.join(" "))
	end

	# Send a private message
	def dm(target, message)
		puts "Trying to send #{target} this direct message: "
		puts message
		message = "d @#{target} #{message}"
		# Make sure target for private message is a follower
		screen_names = @client.followers.collect { |follower| @client.user(follower).screen_name }
		if screen_names.include?(target)
			tweet(message)
		else
			puts "Oops, you can only DM someone who is following you, and #{target} isn't following you!"
		end
	end

	# Send a message to all followers
	def spam_my_followers(message)
		# Get list of all followers
		list = followers_list
		# Send message to each person on list
		list.each { |person| dm(person, message) }
	end

	# Get list of screen names of all followers
	def followers_list
		screen_names = []
		@client.followers.each { |follower| screen_names << @client.user(follower).screen_name }
		return screen_names
	end

	# Find everyone user follows' last tweet
	def everyones_last_tweet
		friends = []
		# Jumpstart Lab tutorial just said to do:
		# friends = @client.friends -- but this didn't work for me
		# Maybe something changed, but I HAD to push @client.user(friend) like with followers above
		@client.friends.each { |friend| friends << @client.user(friend) }
		friends = friends.sort_by { |f| f.screen_name.downcase }
		friends.each do |friend|
			timestamp = friend.status.created_at
			puts "#{friend.screen_name} said at #{timestamp.strftime("%A, %b %d %Y")}..."
			puts friend.status.text
			puts ""
		end
	end

	# Shorten a url
	def shorten(original_url)
	  puts "Shortening this URL: #{original_url}"
		Bitly.use_api_version_3
		bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
		return bitly.shorten(original_url).short_url
	end

end

blogger = MicroBlogger.new
blogger.run