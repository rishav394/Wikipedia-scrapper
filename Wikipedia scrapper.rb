require "rubygems"
require "json"
require 'restclient'
require 'crack'
require 'io/console'

parse=""
ch=""
done=false
t2 =Thread.new do
	loop do
		temp=STDIN.getch
		if temp=="\n"
			done=true
			break
		end
		parse+=temp
	end
end

t=Thread.new do
	loop do
		if done==true
			break
		end
		if parse!=ch
			sleep 1
			url="http://en.wikipedia.org/w/api.php?action=opensearch&search=#{parse}&namespace=0"
			data = Crack::JSON.parse(RestClient.get(url))
			#puts parse
			puts data[1]
			ch=parse
		end
	end
end

t.join
t2.join

puts "Thanks!"
gets