require 'spec/rake/spectask'

desc "Run specs with rcov output"
Spec::Rake::SpecTask.new(:default) do |t|
  t.spec_opts = ['--colour', '--format', 'specdoc']
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.rcov = true
  t.rcov_opts = ['--exclude', 'spec,/usr/lib/ruby', '--text-report']
end
