require_relative "version"

Gem::Specification.new do |spec|
  spec.name = "foobara-ai"
  spec.version = Foobara::Ai::VERSION
  spec.authors = ["Miles Georgi"]
  spec.email = ["azimux@gmail.com"]

  spec.summary = "No description. Add one."
  spec.homepage = "https://github.com/foobara/ai"
  spec.license = "None specified yet"
  spec.required_ruby_version = Foobara::Ai::MINIMUM_RUBY_VERSION

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir[
    "lib/**/*",
    "src/**/*",
    "LICENSE*.txt",
    "README.md",
    "CHANGELOG.md"
  ]

  spec.add_dependency "foobara-anthropic-api"
  spec.add_dependency "foobara-ollama-api"
  spec.add_dependency "foobara-open-ai-api"

  spec.require_paths = ["lib"]
  spec.metadata["rubygems_mfa_required"] = "true"
end
