require_relative "service_enum"
require_relative "../domain_mappers/service_to_list_models_command"
require_relative "../domain_mappers/anthropic_api/model_to_model_enum_string"
require_relative "../domain_mappers/ollama_api/model_to_model_enum_string"
require_relative "../domain_mappers/open_ai_api/model_to_model_enum_string"

module Foobara
  module Ai
    module AnswerBot
      module Types
        models = []

        ServiceEnum.all_values.each do |service|
          list_models_command = AnswerBot.foobara_domain_map!(service)
          models.concat(list_models_command.run!)
        end

        models.map! do |model|
          AnswerBot.foobara_domain_map!(model, to: :string)
        end

        unless models.uniq == models
          # :nocov:
          # TODO: we should return something more complicated than a bare list of strings. Either a more
          # robust object or prefix strings with the relevant service to handle collisions.
          raise "Duplicate models detected"
          # :nocov:
        end

        ModelEnum = Foobara::Enumerated.make_module(models)
      end

      foobara_register_type(:model, :symbol, one_of: Types::ModelEnum)
    end
  end
end
