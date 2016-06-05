load 'yCrypt.rb'

credential   = ARGV[0]
#base_encoded = !(ARGV[1] == "false")

#if base_encoded
	puts Crypt.new("base_encript-sha256").validate(credential, "sha256")
	puts Crypt.new("base_encript-sha1").validate(credential, "sha1")
	puts Crypt.new("base_encript-md5").validate(credential, "md5")
#else
	puts Crypt.new("base").validate(credential)
#end