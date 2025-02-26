module Foobara
  module Ai
    module AnswerBot
      module Types
        ServiceEnum = Foobara::Enumerated.make_module(
          "anthropic",
          "open-ai",
          "ollama"
        )
      end

      foobara_register_type(:service, :symbol, one_of: Types::ServiceEnum)
    end
  end
end
