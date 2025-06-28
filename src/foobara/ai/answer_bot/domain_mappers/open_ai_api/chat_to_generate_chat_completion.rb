require_relative "../../types/model_enum"

module Foobara
  module Ai
    module AnswerBot
      module DomainMappers
        module OpenAiApi
          class ChatToGenerateChatCompletion < Foobara::DomainMapper
            from do
              chat Types::Chat, :required
              temperature :float
              model :model_enum
            end
            to Foobara::Ai::OpenAiApi::CreateChatCompletion

            def map
              inputs = {
                messages: chat.messages.map do |message|
                  { role: message.role, content: message.content }
                end
              }

              if temperature
                inputs[:temperature] = temperature
              end

              if model
                inputs[:model] = model
              end

              inputs
            end

            def chat
              from[:chat]
            end

            def temperature
              from[:temperature]
            end

            def model
              from[:model]
            end
          end
        end
      end
    end
  end
end
