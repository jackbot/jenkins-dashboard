require 'sinatra'
require 'json'
require 'httparty'
require 'dotenv'
Dotenv.load
require_relative 'helpers'

class Dashboard < Sinatra::Base

  helpers DashboardHelpers

  if ENV["DASH_USERNAME"] && ENV["DASH_PASSWORD"]
    use Rack::Auth::Basic, "Bangarang" do |username, password|
      username == ENV["DASH_USERNAME"] and password == ENV["DASH_PASSWORD"]
    end
  end


  def jenkins_projects
    response = jenkins_api_call(:get, "#{ENV['JENKINS_URL']}/api/json")

    return response if response[:error]

    projects = []

    response['jobs'].each do |project|
      project_details = jenkins_api_call(:get, "#{project['url']}/api/json")

      this_project = {:name => project_details["name"], :url => project_details["url"], :builds => []}

      project_details["builds"].each_with_index do |build, index|
        response = jenkins_api_call(:get, "#{build['url']}/api/json")
        next if response[:error]

        this_project[:builds] << {
          :timestamp => Time.at(response["timestamp"].to_i/1000).strftime("%a %e %b %l:%M%P"),
          :nice_timestamp => time_ago_in_words(response["timestamp"]),
          :url => response["url"],
          :result => (response["result"].nil?) ? nil : response["result"].downcase,
          :building => response["building"]
        }

        break if index == 4
      end

      projects << this_project
    end

    {:projects => projects}
  end

  get '/' do
    erb :index
  end

  get '/ajax' do
    puts jenkins_projects.inspect
    jenkins_projects.to_json
  end
end