module Foobara
  module Ai
    module AnswerBot
      class Ask < Foobara::Command
        description "Ask a question and receive the knowledge you seek."

        inputs do
          question :string, :required, description: "whatever you want to know!"
          service :string, one_of: %w[open-ai anthropic], default: "open-ai"
        end

        result :string

        depends_on OpenAiApi::CreateChatCompletion,
                   Foobara::Ai::AnthropicApi::CreateMessage,
                   DomainMappers::OpenAiApi::QuestionToCreateChatCompletion,
                   DomainMappers::AnthropicApi::QuestionToCreateMessage

        def execute
          determine_ai_command
          run_ai_service
          build_answer

          answer
        end

        attr_accessor :ai_command, :response, :answer, :log_entry

        def determine_ai_command
          self.ai_command = if service == "open-ai"
                              OpenAiApi::CreateChatCompletion
                            else
                              Foobara::Ai::AnthropicApi::CreateMessage
                            end
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
