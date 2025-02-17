module Foobara
  module Ai
    module AnswerBot
      module DomainMappers
        module OpenAiApi
          class ChatCompletionToAnswer < Foobara::DomainMapper
            from Foobara::Ai::OpenAiApi::Types::ChatCompletion
            to :string

            def map
              chat_completion.choices.first.message.content
            end

            alias chat_completion from
          end
        end
      end
    end
  end
end
