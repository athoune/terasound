Gem::Specification.new do |s|
  s.name             = "terasound"
  s.version          = "0.0.1alpha"
  s.date             = Time.now.utc.strftime("%Y-%m-%d")
  s.homepage         = "http://github.com/athoune/terasound"
  s.authors          = "Mathieu Lecarme"
  s.email            = "mathieu@garambrogne.net"
  s.description      = "Handle large collection of MP3"
  s.summary          = s.description
  s.extra_rdoc_files = %w(README.md)
  s.files            = Dir["", "README.md", "Gemfile", "lib/**/*.rb"]
  s.require_paths    = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.add_dependency "json"
  s.add_development_dependency "minitest", "~>2.0"
  s.add_development_dependency "rake"
end

