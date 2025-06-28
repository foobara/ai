require_relative "../../types/model_enum"

module Foobara
  module Ai
    module AnswerBot
      module DomainMappers
        module AnthropicApi
          class ChatToCreateMessage < Foobara::DomainMapper
            from do
              chat Types::Chat, :required
              temperature :float
              model :model_enum
            end
            to Foobara::Ai::AnthropicApi::CreateMessage

            def map
              system_messages, non_system_messages = chat.messages.partition(&:system?)

              inputs = {
                messages: non_system_messages.map do |message|
                  { role: message.role, content: message.content }
                end
              }

              unless system_messages.empty?
                inputs[:system] = system_messages.map(&:content).join("\n")
              end

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
