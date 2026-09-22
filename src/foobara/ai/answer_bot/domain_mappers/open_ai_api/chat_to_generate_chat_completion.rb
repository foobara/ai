require_relative "../../types/model_enum"

module Foobara
  module Ai
    module AnswerBot
      module DomainMappers
        module OpenAiApi
          class ChatToGenerateChatCompletion < Foobara::DomainMapper
            from do
              chat Types::Chat, :required
              # NOTE: ignoring temperature for now to prevent breakage
              # TODO: either figure out a deterministic way to know if temperature should be dropped
              # or a way to react to the error with a retry when it happens.
              temperature :float, :allow_nil
              # TODO: shouldn't this be in Types prefix??
              model :"Foobara::Ai::OpenAiApi::model_enum"
            end
            to Foobara::Ai::OpenAiApi::CreateChatCompletion

            def map
              inputs = {
                messages: chat.messages.map do |message|
                  { role: message.role, content: message.content }
                end
              }

              # if temperature
              #   # NOTE: some models don't support temperature, like o1. Instead of possibly receiving an error
              #   # we will set the temperature to 1 which prevents a 400. Maybe print a warning instead?
              #   inputs[:temperature] = model_supports_temperature? ? temperature : 1
              # end

              if model
                inputs[:model] = model
              end

              inputs
            end

            def chat
              from[:chat]
            end

            # def temperature
            #   from[:temperature]
            # end

            def model
              from[:model]
            end

            # def model_supports_temperature?
            #   model && model.to_s !~ /\Ao[13](-|$)/
            # end
          end
        end
      end
    end
  end
end
