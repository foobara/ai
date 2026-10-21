RSpec.describe Foobara::Ai::AnswerBot::GenerateNextMessage do
  let(:command) { described_class.new(inputs) }
  let(:outcome) { command.run }
  let(:result) { outcome.result }
  let(:errors) { outcome.errors }
  let(:errors_hash) { outcome.errors_hash }

  let(:inputs) do
    {
      chat:,
      temperature:,
      model:
    }
  end
  let(:chat) do
    Foobara::Ai::AnswerBot::Types::Chat.new(
      messages: [
        {
          role: :system,
          content: "You are like a scientist that answers questions very concisely and accurately."
        },
        {
          role: :user,
          content: "What is the pH of honey?"
        },
        {
          content: "Honey typically has a pH between 3.4 and 6.1, with an average pH of about 3.9. " \
                   "The acidity of honey is due to the presence of organic acids, primarily gluconic acid, " \
                   "which is produced by glucose oxidase during honey formation.",
          role: :assistant
        },
        {
          role: :user,
          content: "What about vinegar?"
        }
      ]
    )
  end
  let(:temperature) { 0 }

  context "when using open-ai" do
    let(:model) { "gpt-3.5-turbo" }

    it "is successful", vcr: { record: :none } do
      expect(outcome).to be_success
      expect(result.content).to match(/vinegar/i)
    end
  end

  context "when using anthropic" do
    let(:model) { "claude-sonnet-5-5" }

    it "is successful", vcr: { record: :none } do
      expect(outcome).to be_success
      expect(result.content).to match(/vinegar/i)
    end

    context "when there's no text in the result" do
      before do
        allow_any_instance_of(
          Foobara::Ai::AnthropicApi::Types::MessageResult
        ).to receive(:text).and_return(nil)
      end

      it "results in a message_response_was_blank error", vcr: { record: :none } do
        expect(outcome).to_not be_success
        expect(errors_hash.keys).to include("runtime.message_response_was_blank")
      end
    end
  end

  context "when using ollama" do
    let(:model) { "qwen3:4b" }

    it "is successful", vcr: { record: :none } do
      expect(outcome).to be_success
      expect(result.content).to match(/vinegar/i)
    end
  end
end
