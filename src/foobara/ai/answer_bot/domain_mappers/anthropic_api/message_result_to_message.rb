module Foobara
  module Ai
    module AnswerBot
      module DomainMappers
        module AnthropicApi
          class MessageResultToMessage < Foobara::DomainMapper
            from Foobara::Ai::AnthropicApi::Types::MessageResult
            to Types::Message

            def map
              {
                content: message_result.content.last.text,
                role: message_result.role
              }
            end

            alias message_result from
          end
        end
      end
    end
  end
end
