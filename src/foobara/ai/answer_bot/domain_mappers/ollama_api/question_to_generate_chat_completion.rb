require_relative "../../types/model_enum"

module Foobara
  module Ai
    module AnswerBot
      module DomainMappers
        module OllamaApi
          class QuestionToGenerateChatCompletion < Foobara::DomainMapper
            from do
              question :string, :required
              instructions :string,
                           default: "You are a scientific-minded assistant who answers concisely and precisely."

              model :model_enum
            end
            to Foobara::Ai::OllamaApi::GenerateChatCompletion

            def map
              {
                messages: [
                  {
                    role: "system",
                    content: instructions
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

            def instructions
              from[:instructions]
            end
          end
        end
      end
    end
  end
end
