module Foobara
  module Ai
    module AnswerBot
      module DomainMappers
        module AnthropicApi
          class MessageResultToAnswer < Foobara::DomainMapper
            from Foobara::Ai::AnthropicApi::Types::MessageResult
            to :string

            def map
              message.content.first.text
            end

            alias message from
          end
        end
      end
    end
  end
end
