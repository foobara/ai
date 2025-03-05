require "foobara/all"

module Foobara
  module Ai
    foobara_organization!

    module AnswerBot
      foobara_domain!

      require_relative "../../src/foobara/ai/answer_bot/types/service_enum"

      ai_services = {}

      Types::ServiceEnum.all_values.each do |service|
        domain = case service
                 when Types::ServiceEnum::OPEN_AI
                   OpenAiApi
                 when Types::ServiceEnum::ANTHROPIC
                   AnthropicApi
                 when Types::ServiceEnum::OLLAMA
                   OllamaApi
                 end

        ai_services[service] = domain
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
