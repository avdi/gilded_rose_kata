require "rspec"
require_relative "item_aging_rules"

RSpec.describe "Gilded Rose Item Aging Rules" do
  shared_examples_for "a normally aging item" do
    it "reduces 'sell by' days by 1" do
      rule = described_class.new(starting_sell_in: 10)
      rule.apply
      expect(rule.sell_in).to eq(9)
    end
  end

  describe NormalItemAgingRule do
    it_behaves_like "a normally aging item"

    it "reduces quality by 1" do
      rule = NormalItemAgingRule.new(starting_quality: 10)
      rule.apply
      expect(rule.quality).to eq(9)
    end

    it "reduces quality twice as fast on sell by date" do
      rule = NormalItemAgingRule.new(starting_sell_in: 0,
        starting_quality: 10)
      rule.apply
      expect(rule.quality).to eq(8)
    end

    it "reduces quality twice as fast after sell by date" do
      rule = NormalItemAgingRule.new(starting_sell_in: -1,
        starting_quality: 10)
      rule.apply
      expect(rule.quality).to eq(8)
    end
    it "does not allow quality to be less than zero" do
      rule = NormalItemAgingRule.new(starting_quality: 0)
      rule.apply
      expect(rule.quality).to eq(0)
    end
  end

  describe AgedBrieAgingRule do
    it_behaves_like "a normally aging item"

    it "increases quality by 1" do
      rule = AgedBrieAgingRule.new(starting_quality: 10)
      rule.apply
      expect(rule.quality).to eq(11)
    end

    it "increases quality twice as fast on sell by date" do
      rule = AgedBrieAgingRule.new(starting_sell_in: 0,
        starting_quality: 10)
      rule.apply
      expect(rule.quality).to eq(12)
    end

    it "increases quality twice as fast after sell by date" do
      rule = AgedBrieAgingRule.new(starting_sell_in: -1,
        starting_quality: 10)
      rule.apply
      expect(rule.quality).to eq(12)
    end

    it "does not allow quality to increase to more than 50" do
      rule = AgedBrieAgingRule.new(starting_quality: 50)
      rule.apply
      expect(rule.quality).to eq(50)
    end
  end

  it "does not allow quality > 50 even after sell-by" do
    rule = AgedBrieAgingRule.new(starting_quality: 49,
                                 starting_sell_in: -1)
    rule.apply
    expect(rule.quality).to eq(50)
  end

  describe SulfurasAgingRule do
    it "never gets old" do
      rule = described_class.new(starting_sell_in: 10)
      rule.apply
      expect(rule.sell_in).to eq(10)
    end

    it "never loses quality" do
      rule = SulfurasAgingRule.new(starting_quality: 10)
      rule.apply
      expect(rule.quality).to eq(10)
    end
  end

  describe PassesAgingRule do
    it_behaves_like "a normally aging item"

    it "increases quality by 1 when 11 days or more to go" do
      rule = PassesAgingRule.new(starting_quality: 10,
                                 starting_sell_in: 11)
      rule.apply
      expect(rule.quality).to eq(11)
    end

    it "increases quality by 2 when 10 days or less to go" do
      rule = PassesAgingRule.new(starting_quality: 10,
                                 starting_sell_in: 6)
      rule.apply
      expect(rule.quality).to eq(12)
    end

    it "increases quality by 3 when 5 days or less to go" do
      rule = PassesAgingRule.new(starting_quality: 10,
                                 starting_sell_in: 1)
      rule.apply
      expect(rule.quality).to eq(13)
    end

    it "loses all value when concert passes" do
      rule = PassesAgingRule.new(starting_quality: 10,
                                 starting_sell_in: 0)
      rule.apply
      expect(rule.quality).to eq(0)
    end

    it "does not allow quality to increase to more than 50" do
      rule = PassesAgingRule.new(starting_quality: 50)
      rule.apply
      expect(rule.quality).to eq(50)
    end
  end

  describe NormalItemAgingRule do
    it_behaves_like "a normally aging item"

    it "reduces quality by 2" do
      rule = NormalItemAgingRule.new(starting_quality: 10)
      rule.apply
      expect(rule.quality).to eq(9)
    end

    it "reduces quality twice as fast on sell by date" do
      rule = NormalItemAgingRule.new(starting_sell_in: 0,
        starting_quality: 10)
      rule.apply
      expect(rule.quality).to eq(8)
    end

    it "reduces quality twice as fast after sell by date" do
      rule = NormalItemAgingRule.new(starting_sell_in: -1,
        starting_quality: 10)
      rule.apply
      expect(rule.quality).to eq(8)
    end

    it "does not allow quality to be less than zero" do
      rule = NormalItemAgingRule.new(starting_quality: 0)
      rule.apply
      expect(rule.quality).to eq(0)
    end
  end
end
