module Foobara
  module Ai
    module AnswerBot
      module DomainMappers
        module OpenAiApi
          class ChatCompletionResultToMessage < Foobara::DomainMapper
            from Foobara::Ai::OpenAiApi::Types::ChatCompletion
            to Types::Message

            def map
              message = chat_completion.choices.first.message

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
