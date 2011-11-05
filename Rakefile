require 'erb'
require 'ftools'
require 'liquid'
require 'time'
require 'yaml'

BUILD_DIR = File.join(File.dirname(__FILE__), "build")

app_config = open(File.join(File.dirname(__FILE__), 'config.yml')) {|f| YAML.load(f)}

def get_static_files
  FileList['**/*.css', '**/*.html', '**/*.js', '**/*.json', '**/*.png', '**/*.jpg', '**/*.gif'].exclude(/^build/)
end

desc "Builds the manifest.appcache file"
task :build_manifest do
  puts "Building the appcache file …"
  cache_urls = ['/'] + get_static_files()
  network_urls = [
    'http://analytics.pb.io/'
  ]
  
  template = ERB.new File.read('manifest.appcache.erb')
  
  File.open(File.join(BUILD_DIR, 'manifest.appcache'), "w") do |f|
    f.write(template.result(binding))
  end
end

task :build_static do
  puts "Building static files …"
  static_files = get_static_files()
  for file in static_files
    File.makedirs(File.join(BUILD_DIR, File.dirname(file)))
    File.copy(file, File.join(BUILD_DIR, file))
  end
  File.open('index.liquid') do |index_template|
    @index = Liquid::Template.parse(index_template.read())
    File.open(File.join(BUILD_DIR, 'index.html'), 'w') do |index_target|
      index_html = @index.render(
        'debug' => false, 
        'app_name' => app_config['app_name'], 
        'app_title' => app_config['app_title']
      )
      index_target.write(index_html)
    end
  end
end

task :deploy do
  puts "Pushing to Github …"
  sh "git push origin master"
  
  puts "Deploying to Github Pages …"
  sh "cd #{BUILD_DIR} && git add . && git commit -m \"Update app based on `cat ../.git/refs/heads/master`\" && git push origin gh-pages"
end

task :default => [:build_static, :build_manifest, :deploy]
