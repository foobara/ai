require_relative "../../types/model_enum"

module Foobara
  module Ai
    module AnswerBot
      module DomainMappers
        module AnthropicApi
          class QuestionToCreateMessage < Foobara::DomainMapper
            from do
              question :string, :required
              instructions :string,
                           default: "You are a scientific-minded assistant who answers concisely and precisely."
              model :model_enum
            end
            to Foobara::Ai::AnthropicApi::CreateMessage

            def map
              {
                system: instructions,
                messages: [
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
