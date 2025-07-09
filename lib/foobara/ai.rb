require "foobara/all"

module Foobara
  module Ai
    foobara_organization!

    module AnswerBot
      foobara_domain!

      require_relative "../../src/foobara/ai"

      AI_SERVICES = Ai.installed_ai_services

      AI_SERVICES.each_value do |domain|
        foobara_depends_on domain
      end

      base_dir = "#{__dir__}/../../src/foobara/ai/answer_bot"

      AI_SERVICES.each_value do |domain|
        path = Util.underscore(domain.foobara_domain_name)
        require_relative "#{base_dir}/domain_mappers/#{path}/model_to_model_enum_string"
      end

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
