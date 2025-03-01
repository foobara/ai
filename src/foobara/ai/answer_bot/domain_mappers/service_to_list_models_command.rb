require_relative "../types/service_enum"

module Foobara
  module Ai
    module AnswerBot
      module DomainMappers
        class ServiceToChatCompletionCommand < Foobara::DomainMapper
          from :service_enum
          # TODO: create a :class type? Maybe with an inherits: validator?
          to Class

          def map
            case service
            when Types::ServiceEnum::OPEN_AI
              Ai::OpenAiApi::ListModels
            when Types::ServiceEnum::ANTHROPIC
              Ai::AnthropicApi::ListModels
            when Types::ServiceEnum::OLLAMA
              Ai::OllamaApi::ListLocalModels
            else
              # :nocov:
              raise "Unknown service: #{service}"
              # :nocov:
            end
          end

          alias service from
        end
      end
    end
  end
end
