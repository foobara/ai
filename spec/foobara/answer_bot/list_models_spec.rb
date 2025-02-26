RSpec.describe Foobara::Ai::AnswerBot::ListModels do
  let(:command) { described_class.new }
  let(:outcome) { command.run }
  let(:result) { outcome.result }
  let(:errors) { outcome.errors }
  let(:errors_hash) { outcome.errors_hash }

  it "lists all models", vcr: { record: :none } do
    expect(outcome).to be_success
    expect(result).to be_an(Array)
    expect(result).to all be_a(Foobara::Ai::AnswerBot::Types::Model)
  end
end
