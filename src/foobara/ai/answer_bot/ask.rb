module Foobara
  module Ai
    module AnswerBot
      class Ask < Foobara::Command
        description "Ask a question and receive the knowledge you seek."

        inputs do
          question :string, :required, description: "whatever you want to know!"
          service :string, one_of: %w[open-ai anthropic]
          model :model, default: "gpt-3.5-turbo"
        end

        result :string

        depends_on OpenAiApi::CreateChatCompletion,
                   Foobara::Ai::AnthropicApi::CreateMessage
        # including these is now optional
        # DomainMappers::ModelToAiService,
        # DomainMappers::ServiceToCommand,
        # DomainMappers::OpenAiApi::QuestionToCreateChatCompletion,
        # DomainMappers::OpenAiApi::ChatCompletionToAnswer,
        # DomainMappers::AnthropicApi::QuestionToCreateMessage,
        # DomainMappers::AnthropicApi::MessageResultToAnswer
        def execute
          determine_ai_service
          determine_ai_command
          run_ai_service

          answer
        end

        attr_accessor :ai_command, :response, :answer, :ai_service

        def determine_ai_service
          self.ai_service = service || domain_map!(model, from: :model)
        end

        def determine_ai_command
          self.ai_command = domain_map!(ai_service, to: Foobara::Command)
        end

        def run_ai_service
          self.answer = run_mapped_subcommand!(ai_command, question)
        end
      end
    end
  end
end
