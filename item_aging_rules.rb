class NormalItemAgingRule
  attr_reader :quality, :sell_by

  def initialize(starting_quality: 0, starting_sell_by: Float::INFINITY)
    @quality = starting_quality
    @sell_by = starting_sell_by
  end

  def apply
    @quality -= 1 * quality_depreciation_factor unless @quality <= 0
    @sell_by -= 1
  end

  def quality_depreciation_factor
    @sell_by <= 0 ? 2 : 1
  end
end
