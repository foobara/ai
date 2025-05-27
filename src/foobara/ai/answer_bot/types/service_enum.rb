module Foobara
  module Ai
    module AnswerBot
      module Types
        services = [
          "open-ai",
          "anthropic",
          "ollama"
        ]

        ServiceEnum = Foobara::Enumerated.make_module(services)
      end

      foobara_register_type(:service_enum, :symbol, one_of: Types::ServiceEnum)
    end
  end
end
