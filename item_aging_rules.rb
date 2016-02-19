class NormalItemAgingRule
  attr_reader :quality, :sell_in

  def initialize(starting_quality: 0, starting_sell_in: Float::INFINITY)
    @quality = starting_quality
    @sell_in = starting_sell_in
  end

  def apply
    @quality -= 1 * quality_depreciation_factor unless @quality <= 0
    @sell_in -= 1
  end

  def quality_depreciation_factor
    @sell_in <= 0 ? 2 : 1
  end
end

class AgedBrieAgingRule
  attr_reader :quality, :sell_in

  def initialize(starting_quality: 0, starting_sell_in: Float::INFINITY)
    @quality = starting_quality
    @sell_in = starting_sell_in
  end

  def apply
    @quality += 1 * quality_depreciation_factor
    @quality = [@quality, max_quality].min
    @sell_in -= 1
  end

  def max_quality
    50
  end

  def quality_depreciation_factor
    @sell_in <= 0 ? 2 : 1
  end
end
