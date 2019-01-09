$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "booklab/sml/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "booklab-sml"
  spec.version     = BookLab::SML::VERSION
  spec.authors     = ["Jason Lee"]
  spec.email       = ["huacnlee@gmail.com"]
  spec.homepage    = "https://github.com/huacnlee/booklab-sml"
  spec.summary     = "SML is a document format base on JsonML"
  spec.description = "*SML* is a document format base on [JsonML](http://jsonml.org)."
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "activesupport"
  spec.add_dependency "rouge"
end
