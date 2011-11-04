require 'erb'
require 'ftools'
require 'liquid'
require 'time'
require 'yaml'

BUILD_DIR = File.join(File.dirname(__FILE__), "build")

app_config = open(File.join(File.dirname(__FILE__), 'config.yml')) {|f| YAML.load(f)}

def get_static_files
  FileList['**/*.css', '**/*.html', '**/*.js', '**/*.json', '**/*.png', '**/*.jpg', '**/*.gif'].exclude(BUILD_DIR)
end

desc "Builds the cache.manifest appcache file"
task :build_manifest do
  cache_urls = ['/'] + get_static_files()
  network_urls = [
    'http://analytics.pb.io/'
  ]
  
  template = ERB.new File.read('manifest.appcache.erb')
  
  File.open(File.join(BUILD_DIR, 'manifest.appcache'), "w") do |f|
    f.write(template.result(binding))
  end
  
  # sh 'git commit -m "Update manifest." cache.manifest'
end

task :build_static do
  static_files = get_static_files()
  for file in static_files
    File.makedirs(File.join(BUILD_DIR, File.dirname(file)))
    File.copy(file, File.join(BUILD_DIR, file))
  end
  File.open('index.liquid') do |index_template|
    @index = Liquid::Template.parse(index_template.read())
    File.open(File.join(BUILD_DIR, 'index.html'), 'w') do |index_target|
      index_target.write(@index.render(:locals => {
        :debug => false,
        :app_name => app_config['app_name']
      }))
    end
  end
end

task :deploy do
  # sh 'git checkout gh-pages'
  # sh 'git merge master'
  # sh 'git checkout master'
  # sh 'git push --all'
end

task :default => [:build_static, :build_manifest, :deploy]