module DashboardHelpers

  def jenkins_api_call(method, endpoint)
    resp = HTTParty.send(method.to_s, endpoint, :basic_auth => {:username => ENV["JENKINS_API_USER"], :password => ENV["JENKINS_API_PASSWORD"]})
    JSON.parse(resp.body)
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