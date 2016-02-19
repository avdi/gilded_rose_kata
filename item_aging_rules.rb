class NormalItemAgingRule
  def initialize(item)
    @item = item
  end

  def apply
    @item.quality -= 1
  end
end
