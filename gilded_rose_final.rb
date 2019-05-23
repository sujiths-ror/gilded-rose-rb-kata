class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      target = ItemHelper.target_item(item)
      target.new(item).update
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

class BaseItem
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def update
    update_quality
    update_sell_in
  end

  private

  def update_quality; end

  def update_sell_in; end
end

class CommonItem < BaseItem
  private

  def update_quality
    quality = item.quality - (item.sell_in > 0 ? 1 : 2)
    item.quality = [quality, 0].max
  end

  def update_sell_in
    item.sell_in -= 1
  end
end

class ConjuredItem < BaseItem
  private

  def update_quality
    quality = item.quality - (item.sell_in > 0 ? 2 : 4)
    item.quality = [quality, 0].max
  end

  def update_sell_in
    item.sell_in -= 1
  end
end

class BackstageItem < BaseItem
  private

  def update_quality
    quality = if item.sell_in > 10
                item.quality + 1
              elsif item.sell_in > 5
                item.quality + 2
              elsif item.sell_in > 0
                item.quality + 3
              else
                0
              end
    item.quality = quality > 50 ? 50 : quality
  end

  def update_sell_in
    item.sell_in -= 1
  end
end

class SulfurasItem < BaseItem
end

class AgedBrieItem < BaseItem
  private

  def update_quality
    quality = item.quality + (item.sell_in > 0 ? 1 : 2)
    item.quality = [quality, 50].min
  end

  def update_sell_in
    item.sell_in -= 1
  end
end

class ItemHelper
  def self.target_item(item)
    case item.name
    when 'Sulfuras, Hand of Ragnaros'
      SulfurasItem
    when 'Aged Brie'
      AgedBrieItem
    when 'Backstage passes to a TAFKAL80ETC concert'
      BackstageItem
    when 'Conjured Mana Cake'
      ConjuredItem
    else
      CommonItem
    end
  end
end
