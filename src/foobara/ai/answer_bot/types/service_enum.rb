module Foobara
  module Ai
    module AnswerBot
      module Types
        services = []

        services << "open-ai" if defined?(Foobara::Ai::OpenAiApi)
        services << "anthropic" if defined?(Foobara::Ai::AnthropicApi)
        services << "ollama" if defined?(Foobara::Ai::OllamaApi)

        ServiceEnum = Foobara::Enumerated.make_module(services)
      end

      foobara_register_type(:service_enum, :symbol, one_of: Types::ServiceEnum)
    end
  end
end
