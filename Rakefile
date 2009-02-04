require 'spec/rake/spectask'

desc "Run specs with rcov output"
Spec::Rake::SpecTask.new(:default) do |t|
  t.spec_opts = ['--colour', '--format', 'specdoc']
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.rcov = true
  t.rcov_opts = ['--exclude', 'spec,/usr/lib/ruby', '--text-report']
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "ruby-kiva"
    s.summary = "A Ruby wrapper for the Kiva API"
    s.email = "markmcspadden@gmail.com"
    s.homepage = "http://github.com/markmcspadden/ruby-kiva"
    s.description = "A Ruby wrapper for the Kiva API"
    s.authors = ["Mark Mcspadden"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
