require "base64"
class String
  def base64_decode
    begin
      Base64.decode64(self).force_encoding("ISO-8859-1").encode("UTF-8")
    rescue => exception
      return 'unknow encode formant'
    end
  end

  def base64_encode
    Base64.encode64(self).delete!("\n")
  end

  def camel_case_lower
    str = self.split('_').inject([]){ |buffer,e| buffer.push(buffer.empty? ? e : e.capitalize) }.join

    str.split('-').inject([]){ |buffer,e| buffer.push(buffer.empty? ? e : e.capitalize) }.join
  end

  def camel_case_capital
    return self if self !~ /_/ && self =~ /[A-Z]+.*/
    str = split('_').map{|e| e.capitalize}.join

    return str if str !~ /-/ && str =~ /[A-Z]+.*/
    str.split('-').map{|e| e.capitalize}.join
  end

  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end