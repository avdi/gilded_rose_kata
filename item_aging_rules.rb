class NormalItemAgingRule
  attr_reader :quality

  def initialize(starting_quality: 0)
    @quality = starting_quality
  end

  def apply
    @quality -= 1
  end
end
