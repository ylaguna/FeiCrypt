require 'digest'
#require 'pry' #debugger

class Crypt  

  def initialize(base)    
    file = File.read("base/#{base}.txt") 

    @rows  = file.split("\n")
    @start = Time.now
  end 

  def yCryptAll(type)
    ret = File.new("base/base_encript-#{type}.txt", "w+")    

    @rows.each do |row|
      user, password = row.split("|")

      password = yHash(password, type)  
      ret.write "#{user}|#{password}\n"
    end    
    
    ret.close
    time = elapsed_time

    log(time, "op_yCryptAll_#{type}")  
    return "#{type}: Senhas criptografadas. (#{elapsed_time} ms)"  
  end

  def validate(credential, type=false)
    puts "~ Validando com criptografia: #{type}"
    return "Nenhuma credential informada." if credential.nil?
    
    credential = credential.split("|")
    return "Credencial no formato errado, correto: user|password" if credential.count != 2
    
    user, password = credential

    register = @rows.select{|row| row.split("|").first == user}.first
    return "Usuário não encontrado" if register.nil?

    base_password = register.split("|").last
    password = yHash(password, type) if type

    status = (base_password == password) ? "Válido" : "Senha Incorreta"
    
    time = elapsed_time

    log(time, "op_validade-encode_#{type}")
    return "#{status} (#{time} ms)"
  end

  private 

   def yHash(str, type)
    encriptAlg = case type    
    when "sha1"
      Digest::SHA1.new
    when "sha256"
      Digest::SHA256.new
    else #md5
       Digest::MD5.new
    end 

    return encriptAlg.hexdigest
  end

  def elapsed_time
    time = ((Time.now.to_f - @start.to_f)* 1000.0).to_i    

    return time
  end

  def log(str, log_file)      
    f = File.new("log/#{log_file}", "a")
    f.puts str

    f.close
  end

end
