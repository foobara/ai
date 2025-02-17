module Foobara
  module Ai
    module AnswerBot
      module DomainMappers
        module AnthropicApi
          class QuestionToCreateMessage < Foobara::DomainMapper
            from :string
            to Foobara::Ai::AnthropicApi::CreateMessage

            def map
              {
                system: "You are a scientific-minded assistant who answers concisely and precisely.",
                messages: [
                  {
                    role: "user",
                    content: question
                  }
                ]
              }
            end

            alias question from
          end
        end
      end
    end
  end
end
