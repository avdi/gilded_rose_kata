require "rspec"
require_relative "item_aging_rules"
require_relative "gilded_rose"

RSpec.describe "Gilded Rose Item Aging Rules" do
  describe NormalItemAgingRule do
    it "reduces quality by 1" do
      item = Item.new("NORMAL ITEM", 10, 10)
      rule = NormalItemAgingRule.new(item)
      rule.apply
      expect(item.quality).to eq(9)
    end
  end
end
