module DashboardHelpers

  def jenkins_api_call(method, endpoint)
    begin
      response = HTTParty.send(method.to_s, endpoint, :basic_auth => {:username => ENV["JENKINS_API_USER"], :password => ENV["JENKINS_API_PASSWORD"]})
      JSON.parse(response.body)
    rescue SocketError => e
      {:error => true, :message => "Socket Error: Is your Jenkins URL (#{ENV['JENKINS_URL']}) correct?", :full_message => e.message, :backtrace => e.backtrace.join($/)}
    rescue Exception => e
      {:error => true, :message => "Jenkins API error", :full_message => e.message, :backtrace => e.backtrace.join($/)}
    end
  end

  def time_ago_in_words(time)
    delta = Time.now.to_i - (time.to_i / 1000)

    if delta < 5
      "just now"
    elsif delta < 120
      "about a minute ago"
    elsif delta < 3600
      minutes = delta / 60
      "about #{minutes} minutes ago"
    elsif delta < 86400
      hours = delta / 60 / 60
      "about #{hours} #{(hours > 1) ? 'hours' : 'hour'} ago"
    else
      days = delta / 60 / 60 / 24
      "about #{days} #{(days > 1) ? 'days' : 'day'} ago"
    end
  end

end