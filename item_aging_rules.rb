class NormalItemAgingRule
  attr_reader :quality, :sell_by

  def initialize(starting_quality: 0, starting_sell_by: 0)
    @quality = starting_quality
    @sell_by = starting_sell_by
  end

  def apply
    @quality -= 1
    @sell_by -= 1
  end
end
