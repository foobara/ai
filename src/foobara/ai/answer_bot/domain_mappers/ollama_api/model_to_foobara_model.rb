require_relative "../../types/model"

module Foobara
  module Ai
    module AnswerBot
      module DomainMappers
        module OllamaApi
          # TODO: rename these
          class ModelToFoobaraModel < Foobara::DomainMapper
            from Foobara::Ai::OllamaApi::Types::Model
            to Types::Model

            def map
              {
                id: model.model,
                service: Types::ServiceEnum::ANTHROPIC
              }
            end

            alias model from
          end
        end
      end
    end
  end
end
