require "rspec"
require_relative "item_aging_rules"

RSpec.describe "Gilded Rose Item Aging Rules" do
  describe NormalItemAgingRule do
    it "reduces quality by 1" do
      rule = NormalItemAgingRule.new(starting_quality: 10)
      rule.apply
      expect(rule.quality).to eq(9)
    end

    it "reduces 'sell by' days by 1" do
      rule = NormalItemAgingRule.new(starting_sell_in: 10)
      rule.apply
      expect(rule.sell_in).to eq(9)
    end

    it "reduces quality twice as fast on and after sell by date" do
      rule = NormalItemAgingRule.new(starting_sell_in: 0,
                                     starting_quality: 10)
      rule.apply
      expect(rule.quality).to eq(8)
      rule.apply
      expect(rule.quality).to eq(6)
    end

    it "does not allow quality to be less than zero" do
      rule = NormalItemAgingRule.new(starting_quality: 0)
      rule.apply
      expect(rule.quality).to eq(0)
    end
  end
end
