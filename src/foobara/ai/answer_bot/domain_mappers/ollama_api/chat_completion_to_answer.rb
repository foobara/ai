module Foobara
  module Ai
    module AnswerBot
      module DomainMappers
        module OllamaApi
          class ChatCompletionToAnswer < Foobara::DomainMapper
            from Foobara::Ai::OllamaApi::Types::ChatCompletion
            to :string

            def map
              chat_completion.message.content
            end

            alias chat_completion from
          end
        end
      end
    end
  end
end
