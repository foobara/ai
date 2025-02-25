module Foobara
  module Ai
    module AnswerBot
      module DomainMappers
        module AnthropicApi
          class ModelToModelEnumString < Foobara::DomainMapper
            from Foobara::Ai::AnthropicApi::Types::Model
            to :string

            def map
              model.id
            end

            alias model from
          end
        end
      end
    end
  end
end
