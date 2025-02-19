require_relative "../types/model_enum"

module Foobara
  module Ai
    module AnswerBot
      module DomainMappers
        class ModelToAiService < Foobara::DomainMapper
          from :model
          to :string

          def map
            symbol = model.to_sym

            # TODO: use Enumerated::Values#value? instead of #all_values
            if Ai::OpenAiApi::Types::ModelEnum.all_values.include?(symbol)
              "open-ai"
            elsif Ai::AnthropicApi::Types::ModelEnum.all_values.include?(symbol)
              "anthropic"
            else
              # :nocov:
              raise "Unknown model: #{model}"
              # :nocov:
            end
          end

          alias model from
        end
      end
    end
  end
end
