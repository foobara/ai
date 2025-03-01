require_relative "service_enum"
require_relative "../domain_mappers/service_to_list_models_command"
require_relative "../domain_mappers/anthropic_api/model_to_model_enum_string"
require_relative "../domain_mappers/ollama_api/model_to_model_enum_string"
require_relative "../domain_mappers/open_ai_api/model_to_model_enum_string"

module Foobara
  module Ai
    module AnswerBot
      module Types
        threads = ServiceEnum.all_values.map do |service|
          Thread.new do
            service_models = AnswerBot.foobara_domain_map!(service).run!
            service_models.map do |model|
              AnswerBot.foobara_domain_map!(model, to: :string)
            end
          end
        end

        models = threads.each(&:join).map(&:value).flatten

        unless models.uniq == models
          # :nocov:
          # TODO: we should return something more complicated than a bare list of strings. Either a more
          # robust object or prefix strings with the relevant service to handle collisions.
          raise "Duplicate models detected"
          # :nocov:
        end

        ModelEnum = Foobara::Enumerated.make_module(models)
      end

      foobara_register_type(:model_enum, :symbol, one_of: Types::ModelEnum)
    end
  end
end
