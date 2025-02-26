require_relative "../../types/model_enum"

module Foobara
  module Ai
    module AnswerBot
      module DomainMappers
        module OpenAiApi
          # TODO: rename these
          class ModelToFoobaraModel < Foobara::DomainMapper
            from Foobara::Ai::OpenAiApi::Types::Model
            to Types::Model

            def map
              {
                id: model.id,
                service: Types::ServiceEnum::OPEN_AI
              }
            end

            alias model from
          end
        end
      end
    end
  end
end
