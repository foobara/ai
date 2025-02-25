require_relative "../types/model_enum"

module Foobara
  module Ai
    module AnswerBot
      module DomainMappers
        class ModelToAiService < Foobara::DomainMapper
          from :model
          to :string

          def map
            symbol = model.to_sym

            # TODO: use Enumerated::Values#value? instead of #all_values
            if Ai::OpenAiApi::Types::ModelEnum.value?(symbol)
              "open-ai"
            elsif Ai::AnthropicApi::Types::ModelEnum.value?(symbol)
              "anthropic"
            elsif Ai::OllamaApi::Types::ModelEnum.value?(symbol)
              "ollama"
            else
              # :nocov:
              raise "Unknown model: #{model}"
              # :nocov:
            end
          end

          alias model from
        end
      end
    end
  end
end
