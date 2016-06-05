load 'yCrypt.rb' 

base = "base"
puts Crypt.new(base).yCryptAll("sha256")
puts Crypt.new(base).yCryptAll("sha1")
puts Crypt.new(base).yCryptAll("md5")