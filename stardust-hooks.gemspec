#$:.push File.expand_path("../lib", __FILE__)

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "stardust/hooks/version"

Gem::Specification.new do |spec|
  spec.name          = "stardust-hooks"
  spec.version       = Stardust::Hooks::VERSION
  spec.authors       = ["Vic Amuso"]
  spec.email         = ["vic@parablesoft.com"]
  spec.summary       = "Stardust - Hooks module"
  spec.description   = "Stardust - Hooks module"
  spec.homepage      = "https://github.com/parablesoft/stardust-hooks"
  spec.license       = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  spec.add_dependency "rails", "~> 5.0.2"
  spec.add_dependency "sidekiq", "~> 5.2.1"
  spec.add_dependency "pg"
  spec.add_development_dependency "byebug"

end

