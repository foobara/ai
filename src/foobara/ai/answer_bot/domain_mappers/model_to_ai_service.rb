require_relative "../types/model_enum"
require_relative "../types/service_enum"

module Foobara
  module Ai
    module AnswerBot
      module DomainMappers
        class ModelToAiService < Foobara::DomainMapper
          from :model_enum
          to :service_enum

          def map
            symbol = model.to_sym

            AnswerBot::AI_SERVICES.each_pair do |service, domain|
              return service if domain::Types::ModelEnum.value?(symbol)
            end

            # :nocov:
            raise "Unknown model: #{model}"
            # :nocov:
          end

          alias model from
        end
      end
    end
  end
end
