require_relative "../../types/model_enum"

module Foobara
  module Ai
    module AnswerBot
      module DomainMappers
        module OpenAiApi
          class QuestionToCreateChatCompletion < Foobara::DomainMapper
            from do
              question :string, :required
              model :model_enum
            end
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
              }.tap do |inputs|
                if model
                  inputs[:model] = model
                end
              end
            end

            def question
              from[:question]
            end

            def model
              from[:model]
            end
          end
        end
      end
    end
  end
end
