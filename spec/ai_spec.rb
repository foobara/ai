RSpec.describe Foobara::Ai do
  describe ".default_llm_model" do
    subject { described_class.default_llm_model }

    it { is_expected.to be_a(Symbol) }
  end
end
