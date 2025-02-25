module Foobara
  module Ai
    module AnswerBot
      foobara_domain!

      foobara_depends_on OpenAiApi, AnthropicApi, OllamaApi
    end
  end
end
