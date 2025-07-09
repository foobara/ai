require_relative "ai/answer_bot/types/service_enum"

module Foobara
  module Ai
    class << self
      def anthropic_setup?
        defined?(Ai::AnthropicApi)
      end

      def open_ai_setup?
        defined?(Ai::OpenAiApi)
      end

      def ollama_setup?
        defined?(Ai::OllamaApi)
      end

      def installed_ai_services
        return @ai_services if @ai_services

        @ai_services = {}

        if anthropic_setup?
          @ai_services[AnswerBot::Types::ServiceEnum::ANTHROPIC] = AnthropicApi
        end

        if open_ai_setup?
          @ai_services[AnswerBot::Types::ServiceEnum::OPEN_AI] = OpenAiApi
        end

        if ollama_setup?
          @ai_services[AnswerBot::Types::ServiceEnum::OLLAMA] = OllamaApi
        end

        if @ai_services.empty?
          # :nocov:
          require "foobara/anthropic_api"
          @ai_services = { Types::ServiceEnum::ANTHROPIC => AnthropicApi }
          # :nocov:
        end

        @ai_services
      end

      def default_llm_model
        @default_llm_model ||= installed_ai_services.values.first.default_llm_model
      end
    end
  end
end
