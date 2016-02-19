class ItemAgingRule
  attr_reader :quality, :sell_in

  def initialize(starting_quality: 0, starting_sell_in: Float::INFINITY)
    @quality = starting_quality
    @sell_in = starting_sell_in
  end

  def apply
    update_quality
    constrain_quality
    update_sell_in
  end

  def max_quality
    50
  end

  def min_quality
    0
  end

  def update_quality
    @quality += 1 * quality_change_factor
  end

  def constrain_quality
    @quality = [@quality, max_quality].min
    @quality = [@quality, min_quality].max
  end

  def update_sell_in
  end

  def quality_change_factor
    0
  end
end

class NormalItemAgingRule < ItemAgingRule
  def apply
    update_quality
    constrain_quality
    @sell_in -= 1
  end

  def quality_change_factor
    @sell_in <= 0 ? -2 : -1
  end
end

class AgedBrieAgingRule < ItemAgingRule
  def apply
    update_quality
    @quality = [@quality, max_quality].min
    @sell_in -= 1
  end

  def quality_change_factor
    @sell_in <= 0 ? 2 : 1
  end
end

class SulfurasAgingRule < ItemAgingRule
  def max_quality
    80
  end
end

class PassesAgingRule < ItemAgingRule
  def apply
    @quality += 1 * quality_change_factor
    @quality = 0 if @sell_in <= 0
    @quality = [@quality, max_quality].min
    @sell_in -= 1
  end

  def quality_change_factor
    case @sell_in
    when 11..Float::INFINITY    then 1
    when 6..10                  then 2
    when 1..5                   then 3
    else                             0
    end
  end
end
