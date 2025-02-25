RSpec.describe Foobara::Ai::AnswerBot::Ask do
  let(:command) { described_class.new(inputs) }
  let(:outcome) { command.run }
  let(:result) { outcome.result }
  let(:errors) { outcome.errors }
  let(:errors_hash) { outcome.errors_hash }

  let(:inputs) do
    {
      question: "what is the pH of honey?",
      model:
    }
  end

  context "when using open-ai" do
    let(:model) { "gpt-3.5-turbo" }

    it "is successful", vcr: { record: :none } do
      expect(outcome).to be_success
      expect(result).to match(/honey/i)
    end
  end

  context "when using anthropic" do
    let(:model) { "claude-3-5-sonnet-20241022" }

    it "is successful", vcr: { record: :none } do
      expect(outcome).to be_success
      expect(result).to match(/honey/i)
    end
  end

  context "when using ollama" do
    let(:model) { "smollm2:135m" }

    it "is successful", vcr: { record: :none } do
      expect(outcome).to be_success
      expect(result).to match(/honey/i)
    end
  end
end
