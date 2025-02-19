module Foobara
  module Ai
    module AnswerBot
      module Types
        models = OpenAiApi::Types::ModelEnum.all_values + AnthropicApi::Types::ModelEnum.all_values

        unless models.uniq == models
          # :nocov:
          raise "Duplicate models detected"
          # :nocov:
        end

        ModelEnum = Foobara::Enumerated.make_module(models)

        AnswerBot.foobara_register_type(:model, :string, one_of: ModelEnum)
      end
    end
  end
end
