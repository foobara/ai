require_relative "../../types/model"

module Foobara
  module Ai
    module AnswerBot
      module DomainMappers
        module AnthropicApi
          # TODO: rename these
          class ModelToFoobaraModel < Foobara::DomainMapper
            from Foobara::Ai::AnthropicApi::Types::Model
            to Types::Model

            def map
              {
                id: model.id,
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
