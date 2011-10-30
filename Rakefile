require 'time'

task :build_manifest do
  files = FileList['**/*.css', '**/*.html', '**/*.js', '**/*.json', '**/*.png', '**/*.jpg', '**/*.gif']
  manifest = "CACHE MANIFEST\n"
  files.each do |file|
    manifest = manifest + "#{file}\n"
  end
  manifest = manifest + "# #{Time.now.utc.iso8601}\n"
  File.open('cache.manifest', 'w') {|f| f.write manifest }
  sh 'git commit -m "Update manifest." cache.manifest'
end

task :deploy do
  sh 'git checkout gh-pages'
  sh 'git merge master'
  sh 'git checkout master'
  sh 'git push --all'
end

task :default => [:build_manifest, :deploy]