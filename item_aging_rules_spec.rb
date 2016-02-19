require "rspec"
require_relative "item_aging_rules"

RSpec.describe "Gilded Rose Item Aging Rules" do
  describe NormalItemAgingRule do
    it "reduces quality by 1" do
      rule = NormalItemAgingRule.new(starting_quality: 10)
      rule.apply
      expect(rule.quality).to eq(9)
    end
  end
end
