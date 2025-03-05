# Foobara::Ai

Implements a simple mental model of asking LLM services a question and getting an answer. Allows one
to ask a question and get an answer while specifying which service to use as
its implementation.

## Installation

Typical stuff. Add `gem "foobara-ai"` to your Gemfile or .gemspec. Or if using in a local script you can also
`gem install foobara-ai`. You also need to do the same for some combination of foobara-open-ai-api,
foobara-anthropic-api, or foobara-ollama-api, depending on which models you wish to ask against.

## Usage

You need to require whichever services you want to use before requiring foobara/ai.

```ruby
> require "foobara/open_ai_api"
> require "foobara/anthropic_api"
> require "foobara/ollama_api"
> require "foobara/ai"
> result = Ask.run!(question: "What is the pH of honey?", model: "gpt-3.5-turbo")
> puts result
The pH of honey typically ranges between 3.2 and 4.5.
>
```

## Contributing

Bug reports and pull requests are welcome on GitHub
at https://github.com/foobara/ai

## License

The gem is available as open source under the terms of the MPL-2.0 License.
See [LICENSE.txt](LICENSE.txt) for more info.
