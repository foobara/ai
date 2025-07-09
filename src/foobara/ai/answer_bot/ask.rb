module Foobara
  module Ai
    module AnswerBot
      class Ask < Foobara::Command
        description "Ask a question and receive the knowledge you seek."

        inputs do
          question :string, :required, "whatever you want to know!"
          instructions :string, "Results in a system prompt. You can specify how you want the LLM to behave."
          service :service_enum, "If two services expose the same model, you can specify which one to use."
          model :model_enum, default: Ai.default_llm_model, description: "The model to use."
        end

        result :string

        AI_SERVICES.each_key do |service|
          command = Foobara::Ai::AnswerBot::DomainMappers::ServiceToChatCompletionCommand.map!(service)
          depends_on command
        end

        def execute
          determine_ai_service
          determine_ai_command
          run_ai_service

          answer
        end

        attr_accessor :ai_command, :response, :answer, :ai_service

        def determine_ai_service
          self.ai_service = service || domain_map!(model, from: :model_enum)
        end

        def determine_ai_command
          self.ai_command = Foobara::Ai::AnswerBot::DomainMappers::ServiceToChatCompletionCommand.map!(ai_service)
        end

        def run_ai_service
          inputs = { question:, model: }

          if instructions
            inputs[:instructions] = instructions
          end

          inputs = domain_map!(inputs, to: ai_command)
          answer = run_subcommand!(ai_command, inputs)

          self.answer = domain_map!(answer, to: :string)
        end
      end
    end
  end
end
