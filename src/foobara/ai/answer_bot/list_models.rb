require_relative "domain_mappers/anthropic_api/model_to_model_enum_string"
require_relative "domain_mappers/ollama_api/model_to_model_enum_string"
require_relative "domain_mappers/open_ai_api/model_to_model_enum_string"

module Foobara
  module Ai
    module AnswerBot
      class ListModels < Foobara::Command
        description "List of all model strings you can use"

        result [:string]

        LIST_COMMANDS = [
          OpenAiApi::ListModels,
          AnthropicApi::ListModels,
          OllamaApi::ListLocalModels
        ].freeze

        depends_on(*LIST_COMMANDS)

        def execute
          run_each_list_command_and_collect_models
          map_models_to_model_enum_strings
          sort_model_enum_strings

          model_enum_strings
        end

        attr_accessor :model_enum_strings

        def models
          @models ||= []
        end

        def run_each_list_command_and_collect_models
          threads = []

          LIST_COMMANDS.map do |list_command|
            Thread.new { models.concat(run_subcommand!(list_command)) }
          end.each(&:join)

          threads.each(&:join)
        end

        def map_models_to_model_enum_strings
          self.model_enum_strings = models.map { |model| domain_map!(model) }
        end

        def sort_model_enum_strings
          model_enum_strings.sort!
        end
      end
    end
  end
end
