require 'digest'

class AuthExt
  SHARED_SECRET = "55597e88836406ce96973b97546411be6fa12ebffc8c5d62980b4ef0cd45"
  SIGNATURE_EXPIRATION_SECONDS = 3600 # 1 hour

  def incoming(message, callback)
    if message['channel'] == '/meta/subscribe'
      authenticate_subscribe(message)
    elsif message['channel'] !~ %r{^/meta/}
      authenticate_publish(message)
    end
    callback.call(message)
  end

  private

    def authenticate_subscribe(message)
      if message["ext"]["token"] == SHARED_SECRET
        return
      elsif message["ext"]["signature"] != signature(message["subscription"], message["ext"]["timestamp"])
        message["error"] = "Incorrect signature."
      elsif signature_expired?(message["ext"]["timestamp"].to_i)
        message["error"] = "Signature has expired."
      end
    end

    def authenticate_publish(message)
      if message["ext"]["token"] != SHARED_SECRET
        message["error"] = "Incorrect token."
      else
        message["ext"]["token"] = nil
      end
    end

    def signature(channel, timestamp)
      Digest::SHA1.hexdigest([SHARED_SECRET, channel, timestamp].join)
    end

    def signature_expired?(timestamp)
      timestamp < ((Time.now.to_f - SIGNATURE_EXPIRATION_SECONDS) * 1000).round
    end

end