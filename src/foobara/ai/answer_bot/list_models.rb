require_relative "types/service_enum"
require_relative "types/model"

module Foobara
  module Ai
    module AnswerBot
      class ListModels < Foobara::Command
        description "List of all model strings you can use"

        result [Types::Model]

        LIST_COMMANDS = AI_SERVICES.keys.map do |service|
          Foobara::Ai::AnswerBot::DomainMappers::ServiceToListModelsCommand.map!(service)
        end

        depends_on(*LIST_COMMANDS)

        def execute
          run_each_list_command_and_collect_models
          map_to_foobara_models
          sort_models

          models
        end

        def service_models
          @service_models ||= []
        end

        attr_accessor :models

        def run_each_list_command_and_collect_models
          threads = LIST_COMMANDS.map do |list_command|
            Thread.new { service_models.concat(run_subcommand!(list_command)) }
          end

          self.models = threads.each(&:join).map(&:value)
        end

        def map_to_foobara_models
          self.models = service_models.map do |model|
            domain_map!(model, to: Types::Model)
          end
        end

        def sort_models
          models.sort_by! do |model|
            [model.service, model.id]
          end
        end
      end
    end
  end
end
