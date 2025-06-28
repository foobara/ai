module Foobara
  module Ai
    module AnswerBot
      module Types
        class Chat < Foobara::Model
          attributes do
            messages [Message]
          end
        end
      end
    end
  end
end
