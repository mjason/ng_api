$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ng_api/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ng_api"
  s.version     = NgApi::VERSION
  s.authors     = ["mjason"]
  s.email       = ["tywf91@gmail.com"]
  s.homepage    = "http://open.bestng.me"
  s.summary     = "init api on rails"
  s.description = "rails api"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"

end
