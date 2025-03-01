require_relative "../types/model_enum"
require_relative "../types/service_enum"

module Foobara
  module Ai
    module AnswerBot
      module DomainMappers
        class ModelToAiService < Foobara::DomainMapper
          from :model_enum
          to :service

          def map
            symbol = model.to_sym

            # TODO: use Enumerated::Values#value? instead of #all_values
            if Ai::OpenAiApi::Types::ModelEnum.value?(symbol)
              Types::ServiceEnum::OPEN_AI
            elsif Ai::AnthropicApi::Types::ModelEnum.value?(symbol)
              Types::ServiceEnum::ANTHROPIC
            elsif Ai::OllamaApi::Types::ModelEnum.value?(symbol)
              Types::ServiceEnum::OLLAMA
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
