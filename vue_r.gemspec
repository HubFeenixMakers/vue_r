require_relative "lib/vue_r/version"

Gem::Specification.new do |spec|
  spec.name        = "vue_r"
  spec.version     = VueR::VERSION
  spec.authors     = ["Torsten"]
  spec.email       = ["torsten@rubydesign.fi"]
  spec.homepage    = "https://github.com/HubFeenixMakers/vue_r"
  spec.summary     = "Reactively program DOM in ruby, Vue.js inspired"
  spec.description = "Using opal to emulate vue functionality, usable, but aplha."
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/HubFeenixMakers/vue_r"
  spec.metadata["changelog_uri"] = "https://github.com/HubFeenixMakers/vue_r"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "opal-rails", ">= 2.0"
  spec.add_dependency "opal-browser", ">= 0.3.0"
end
