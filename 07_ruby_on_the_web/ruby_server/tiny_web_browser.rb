require 'socket'

host = 'www.tutorialspoint.com'			# Web server
port = 80														# HTTP port
path = "/index.htm"									# File we want

# HTTP request to fetch a file
request = "GET #{path} HTTP/1.0\r\n\r\n"

socket = TCPSocket.open(host,port)	# Connect to server
socket.print(request)								# Send request
response = socket.read							# Read complete response
# Split response at first blank line into headers and body
headers,body = response.split("\r\n\r\n", 2)
print body													# Display it

