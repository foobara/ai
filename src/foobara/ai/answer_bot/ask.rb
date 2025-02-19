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
                   Foobara::Ai::AnthropicApi::CreateMessage,
                   # TODO: can we make it not required to depend on domain mappers??
                   DomainMappers::OpenAiApi::QuestionToCreateChatCompletion,
                   DomainMappers::AnthropicApi::QuestionToCreateMessage

        def execute
          determine_ai_service
          determine_ai_command
          run_ai_service
          build_answer

          answer
        end

        attr_accessor :ai_command, :response, :answer, :ai_service

        def determine_ai_service
          self.ai_service = service || domain_map(model, to: :string)
        end

        def determine_ai_command
          # Why does this work???
          self.ai_command = domain_map(ai_service, to: Foobara::Command)
        end

        def run_ai_service
          self.response = run_mapped_subcommand!(ai_command, question)
        end

        def build_answer
          self.answer = domain_map(response)
        end
      end
    end
  end
end
