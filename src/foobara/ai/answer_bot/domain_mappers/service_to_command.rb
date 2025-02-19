module Foobara
  module Ai
    module AnswerBot
      module DomainMappers
        class ServiceToCommand < Foobara::DomainMapper
          from :string
          # TODO: create a :class type? Maybe with an inherits: validator?
          to Class

          def map
            case service
            when "open-ai"
              Ai::OpenAiApi::CreateChatCompletion
            when "anthropic"
              Ai::AnthropicApi::CreateMessage
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
