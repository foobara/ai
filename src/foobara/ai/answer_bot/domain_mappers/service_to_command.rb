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
              Ai::OpenAiApi::CreateChatCompletion
            when Types::ServiceEnum::ANTHROPIC
              Ai::AnthropicApi::CreateMessage
            when Types::ServiceEnum::OLLAMA
              Ai::OllamaApi::GenerateChatCompletion
            else
              # simplecov:disable
              raise "Unknown service: #{service}"
              # simplecov:enable
            end
          end

          alias service from
        end
      end
    end
  end
end
