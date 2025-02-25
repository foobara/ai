module Foobara
  module Ai
    module AnswerBot
      module DomainMappers
        module OpenAiApi
          class ModelToModelEnumString < Foobara::DomainMapper
            from Foobara::Ai::OpenAiApi::Types::Model
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
