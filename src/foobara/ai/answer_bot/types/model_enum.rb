require_relative "../list_models"

module Foobara
  module Ai
    module AnswerBot
      module Types
        models = ListModels.run!

        unless models.uniq == models
          # :nocov:
          # TODO: we should return something more complicated than a bare list of strings. Either a more
          # robust object or prefix strings with the relevant service to handle collisions.
          raise "Duplicate models detected"
          # :nocov:
        end

        ModelEnum = Foobara::Enumerated.make_module(models)
      end

      foobara_register_type(:model, :string, one_of: Types::ModelEnum)
    end
  end
end
