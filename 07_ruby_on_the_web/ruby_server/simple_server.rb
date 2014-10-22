require 'socket' 							# Get sockets

server = TCPServer.open(2000) # Socket listens on port 2000
loop {  											# Server runs forever
	client = server.accept			# Wait for client to connect
	client.puts(Time.now.ctime)	# Send time to client
	client.puts "Closing connection"
	client.close								# Disconnect from client
}