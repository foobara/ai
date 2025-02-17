RSpec.describe Foobara::Ai::AnswerBot::Ask do
  let(:command) { described_class.new(inputs) }
  let(:outcome) { command.run }
  let(:result) { outcome.result }
  let(:errors) { outcome.errors }
  let(:errors_hash) { outcome.errors_hash }

  let(:inputs) do
    {
      question: "what is the pH of honey?",
      service:
    }
  end
  let(:service) { "open-ai" }

  it "is successful", vcr: { record: :none } do
    expect(outcome).to be_success
    expect(result).to match(/honey/i)
  end

  context "when using anthropic" do
    let(:service) { "anthropic" }

    it "is successful", vcr: { record: :none } do
      expect(outcome).to be_success
      expect(result).to match(/honey/i)
    end
  end
end
