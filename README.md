# Foobara::Ai

Currently, gives an Ask command based on the foobara code demo. Allows one
to ask a question and get an answer while specifying which service to use as
its implementation.

## Installation

Typical stuff. Add `gem "foobara-ai"` to your Gemfile or .gemspec. Or if using in a local script you can also
`gem install foobara-ai`

## Usage

```ruby
> result = Ask.run!(question: "What is the pH of honey?", service: "open-ai")
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
