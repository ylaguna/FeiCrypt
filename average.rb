logs = Dir["log/*"]

#Retorna tempo médio dos testes no log :)

logs.each do |log|
	values = File.read(log).split("\n").map(&:to_i)

	name = log.match(/op_(.*)/)[1]
	avr = values.inject(:+)/values.size

	puts "#{name}: #{avr} ms"
end

