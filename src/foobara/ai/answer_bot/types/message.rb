module Foobara
  module Ai
    module AnswerBot
      module Types
        class Message < Foobara::Model
          attributes do
            role :symbol, one_of: [:assistant, :user, :system]
            content :string
          end

          def system?
            role == :system
          end
        end
      end
    end
  end
end
