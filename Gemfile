require_relative "version"

source "https://rubygems.org"
ruby Foobara::Ai::MINIMUM_RUBY_VERSION

gemspec

# gem "foobara", path: "../foobara"
gem "foobara-dotenv-loader", "< 2.0.0"

gem "rake"

group :development do
  gem "foob"
  gem "foobara-rubocop-rules"
  gem "guard-rspec"
  gem "rubocop-rake"
  gem "rubocop-rspec"
end

group :development, :test do
  gem "foobara-anthropic-api",  ">= 1.0.1", "< 2.0.0" # , path: "../anthropic-api"
  gem "foobara-ollama-api", ">= 1.0.0", "< 2.0.0" # , path: "../ollama-api"
  gem "foobara-open-ai-api", ">= 1.0.1", "< 2.0.0" # , path: "../open-ai-api"
  gem "pry"
  gem "pry-byebug"
  # TODO: Just adding this to suppress warnings seemingly coming from pry-byebug. Can probably remove this once
  # pry-byebug has irb as a gem dependency
  gem "irb"
end

group :test do
  gem "foobara-spec-helpers"
  gem "rspec"
  gem "rspec-its"
  gem "ruby-prof"
  gem "simplecov"
  gem "vcr"
  gem "webmock"
end
