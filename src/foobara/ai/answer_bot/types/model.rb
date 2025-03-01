require_relative "model_enum"
require_relative "service_enum"

module Foobara
  module Ai
    module AnswerBot
      module Types
        class Model < Foobara::Model
        end

        class Model < Foobara::Model
          attributes do
            id :model_enum, :required
            service :service, :required
          end
        end
      end
    end
  end
end
