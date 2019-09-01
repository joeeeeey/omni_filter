require "base64"
class String
  def base64_decode
    Base64.decode64(self)
  end

  def base64_encode
    Base64.encode64(self).delete!("\n")
  end
end