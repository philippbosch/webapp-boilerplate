require 'erb'
require 'time'

OUTPUT_FILE = 'cache.manifest'
TEMPLATE_FILE = 'cache.manifest.template'

desc "Builds the cache.manifest appcache file"
task :build_manifest do
  cache_urls = ['/'] + FileList['**/*.css', '**/*.html', '**/*.js', '**/*.json', '**/*.png', '**/*.jpg', '**/*.gif']
  network_urls = [
    'http://analytics.pb.io/'
  ]
  
  template = ERB.new File.read(TEMPLATE_FILE)
  
  File.open(OUTPUT_FILE, "w") do |f|
    f.write(template.result(binding))
  end
  
  sh 'git commit -m "Update manifest." cache.manifest'
end

task :deploy do
  sh 'git checkout gh-pages'
  sh 'git merge master'
  sh 'git checkout master'
  sh 'git push --all'
end

task :default => [:build_manifest, :deploy]