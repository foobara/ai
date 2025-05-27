require_relative "service_enum"
require_relative "../domain_mappers/service_to_list_models_command"

module Foobara
  module Ai
    module AnswerBot
      module Types
        models = []
        AI_SERVICES.each_key do |service|
          service_models = AnswerBot.foobara_domain_map!(service).run!
          service_models.map do |model|
            models << AnswerBot.foobara_domain_map!(model, to: :string)
          end
        end

        # Doing this in a threaded fashion creates a race condition somewhere for some unidentified reason
        # so commenting this all out for now.
        #
        # threads = AI_SERVICES.keys.map do |service|
        #           Thread.new do
        #             service_models = AnswerBot.foobara_domain_map!(service).run!
        #             service_models.map do |model|
        #               AnswerBot.foobara_domain_map!(model, to: :string)
        #             end
        #           end
        #         end
        #
        #         models = threads.each(&:join).map(&:value).flatten

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
