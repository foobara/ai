module Foobara
  module Ai
    module AnswerBot
      module DomainMappers
        module OllamaApi
          class ModelToModelEnumString < Foobara::DomainMapper
            from Foobara::Ai::OllamaApi::Types::Model
            to :string

            def map
              model.model
            end

            alias model from
          end
        end
      end
    end
  end
end
