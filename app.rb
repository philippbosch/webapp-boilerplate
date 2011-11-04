require 'sinatra'
require 'yaml'

app_config = open(File.join(File.dirname(__FILE__), 'config.yml')) {|f| YAML.load(f)}

configure do
  set :environment, :development
  set :public, Proc.new { root }
  set :views, Proc.new { root }
  set :port, app_config['port']
end

get '/' do
  liquid :index, :locals => {
    :debug => settings.environment == :development,
    :app_name => app_config['app_name']
  }
end