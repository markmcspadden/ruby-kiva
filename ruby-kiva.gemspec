Gem::Specification.new do |s|
  s.name = %q{ruby-kiva}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mark Mcspadden"]
  s.date = %q{2009-02-04}
  s.description = %q{A Ruby wrapper for the Kiva API}
  s.email = %q{markmcspadden@gmail.com}
  s.files = ["VERSION.yml", "lib/kiva", "lib/kiva/loan.rb", "lib/kiva.rb", "lib/ruby-kiva.rb", "spec/kiva", "spec/kiva/loan_spec.rb", "spec/spec_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/markmcspadden/ruby-kiva}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{A Ruby wrapper for the Kiva API}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
    else
    end
  else
  end
end
