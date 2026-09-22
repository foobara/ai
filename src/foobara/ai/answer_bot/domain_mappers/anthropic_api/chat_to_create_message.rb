require_relative "../../types/model_enum"

module Foobara
  module Ai
    module AnswerBot
      module DomainMappers
        module AnthropicApi
          class ChatToCreateMessage < Foobara::DomainMapper
            # TODO: why doesn't this have a model?
            from do
              chat Types::Chat, :required
              # NOTE: temperature is not supported by Anthropic these days and it is ignored
              temperature :float, :allow_nil, "temperature is not supported by Anthropic these days and it is ignored"
              # TODO: shouldn't this be in Types prefix??
              model :"Foobara::Ai::AnthropicApi::model_enum"
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

              if model
                inputs[:model] = model
              end

              inputs
            end

            def chat
              from[:chat]
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
