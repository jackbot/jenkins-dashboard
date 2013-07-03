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
    projects_resp = jenkins_api_call(:get, "#{ENV['JENKINS_URL']}/api/json")['jobs']
    projects = []

    projects_resp.each do |project|
      deets = jenkins_api_call(:get, "#{project['url']}/api/json")
      this_project = {:name => deets["name"], :url => deets["url"], :builds => []}

      ctr = 0
      deets["builds"].each do |build|
        resp = jenkins_api_call(:get, "#{build['url']}/api/json")

        this_project[:builds] << {:timestamp => Time.at(resp["timestamp"].to_i/1000).strftime("%a %e %b %l:%M%P"), :nice_timestamp => time_ago_in_words(resp["timestamp"]), :url => resp["url"], :result => (resp["result"].nil?) ? nil : resp["result"].downcase, :building => resp["building"]}

        ctr += 1
        break if ctr == 5
      end

      projects << this_project

    end

    projects
  end

  get '/' do
    @jenkins_projects = jenkins_projects
    erb :index
  end

  get '/ajax' do
    {"projects" => jenkins_projects}.to_json
  end
end