require_relative "item_aging_rules"

def rule_for(item)
  case item.name
  when 'Aged Brie'
    AgedBrieAgingRule.new(starting_quality: item.quality,
                          starting_sell_in: item.sell_in)
  when 'Sulfuras, Hand of Ragnaros'
    SulfurasAgingRule.new(starting_quality: item.quality,
                          starting_sell_in: item.sell_in)
  when 'Backstage passes to a TAFKAL80ETC concert'
    PassesAgingRule.new(starting_quality: item.quality,
                        starting_sell_in: item.sell_in)
  else
    NormalItemAgingRule.new(starting_quality: item.quality,
                            starting_sell_in: item.sell_in)
  end
end

def update_quality(items)
  items.each do |item|
    rule = rule_for(item)
    rule.apply
    item.sell_in = rule.sell_in
    item.quality = rule.quality
  end
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]
