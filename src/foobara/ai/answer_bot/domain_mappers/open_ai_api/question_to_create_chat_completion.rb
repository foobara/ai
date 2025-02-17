module Foobara
  module Ai
    module AnswerBot
      module DomainMappers
        module OpenAiApi
          class QuestionToCreateChatCompletion < Foobara::DomainMapper
            from :string
            to Foobara::Ai::OpenAiApi::CreateChatCompletion

            def map
              {
                messages: [
                  {
                    role: "system",
                    content: "You are a scientific-minded assistant who answers concisely and precisely."
                  },
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
