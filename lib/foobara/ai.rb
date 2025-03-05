require "foobara/all"

module Foobara
  module Ai
    foobara_organization!

    module AnswerBot
      foobara_domain!

      require_relative "../../src/foobara/ai/answer_bot/types/service_enum"

      ai_services = {}

      if defined?(Foobara::Ai::OpenAiApi)
        ai_services[Types::ServiceEnum::OPEN_AI] = OpenAiApi
      end
      if defined?(Foobara::Ai::AnthropicApi)
        ai_services[Types::ServiceEnum::ANTHROPIC] = AnthropicApi
      end
      if defined?(Foobara::Ai::OllamaApi)
        ai_services[Types::ServiceEnum::OLLAMA] = OllamaApi
      end

      ai_services.each_value do |domain|
        foobara_depends_on domain
      end

      AI_SERVICES = ai_services

      base_dir = "#{__dir__}/../../src/foobara/ai/answer_bot"
      Util.require_directory "#{base_dir}/types"
      Dir["#{base_dir}/domain_mappers/*.rb"].each { |f| require f }
      Dir["#{base_dir}/*.rb"].each { |f| require f }

      AI_SERVICES.each_value do |domain|
        path = Util.underscore(domain.foobara_domain_name)
        Util.require_directory "#{base_dir}/domain_mappers/#{path}"
      end
    end
  end
end
