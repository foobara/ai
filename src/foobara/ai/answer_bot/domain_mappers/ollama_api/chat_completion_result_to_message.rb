module Foobara
  module Ai
    module AnswerBot
      module DomainMappers
        module OllamaApi
          class ChatCompletionResultToMessage < Foobara::DomainMapper
            from Foobara::Ai::OllamaApi::Types::ChatCompletion
            to Types::Message

            def map
              message = chat_completion.message

              {
                content: message.content,
                role: message.role
              }
            end

            alias chat_completion from
          end
        end
      end
    end
  end
end
