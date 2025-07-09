module Foobara
  module Ai
    module AnswerBot
      class GenerateNextMessage < Foobara::Command
        description "Takes a chat and generates the next message using the model of your choice."

        inputs do
          chat Types::Chat, :required
          service :service_enum, "If two services expose the same model, you can specify which one to use."
          model :model_enum, default: Ai.default_llm_model, description: "The model to use."
          temperature :float
        end

        result Types::Message

        AI_SERVICES.each_key do |service|
          command = Foobara::Ai::AnswerBot::DomainMappers::ServiceToChatCompletionCommand.map!(service)
          depends_on command
        end

        def execute
          determine_ai_service
          determine_ai_command
          run_ai_service

          next_message
        end

        attr_accessor :ai_command, :response, :ai_service, :next_message

        def determine_ai_service
          self.ai_service = service || domain_map!(model, from: :model_enum)
        end

        def determine_ai_command
          self.ai_command = Foobara::Ai::AnswerBot::DomainMappers::ServiceToChatCompletionCommand.map!(ai_service)
        end

        def run_ai_service
          inputs = { chat:, temperature:, model: }
          inputs = domain_map!(inputs, to: ai_command)
          next_message = run_subcommand!(ai_command, inputs)

          self.next_message = domain_map!(next_message, to: Types::Message)
        end
      end
    end
  end
end
