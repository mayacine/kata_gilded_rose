class GildedRose

  def initialize(items)
    @items = Builder.build(items)
  end

  def update_quality_old()
    @items.each do |item|
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > 0
          if item.name != "Sulfuras, Hand of Ragnaros"
            item.quality = item.quality - 1
          end
        end
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
        end
      end
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in = item.sell_in - 1
      end
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              if item.name != "Sulfuras, Hand of Ragnaros"
                item.quality = item.quality - 1
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end
    end
  end

  def update_quality()
     @items.each do |item|
      item.sell_in, item.quality = ItemBuilder.new(item: item).build.update_quality
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

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end

  def update_quality
  end
end

class DefaultItem < Item
  def initialize(name, sell_in, quality)
    raise StandardError , 'cannot exceed 50' if quality > 50
 
    super
  end

  def update_quality
    self.quality -=1 unless quality.zero?
    self.sell_in -=1 
  end
end

class AgedBrie < DefaultItem
  def update_quality
  end
end

class SulfurasItem < DefaultItem
  def update_quality
    @sell_in, @quality
  end
end

class BackstageItem < DefaultItem
  def update_quality
  end
end

class ItemBuilder
  def initialize(item:)
    @item = item
  end

  def build
    class_name_item = ITEM_DICO[@item.name.to_sym] || DefaultItem

    class_name_item.new(@item.name, @item.sell_in, @item.quality)
  end

  ITEM_DICO =  { 
    "Aged Brie": AgedBrie,
    "Sulfuras, Hand of Ragnaros": SulfurasItem,
    "Backstage passes to a TAFKAL80ETC concert": BackstageItem
    "Conjured": BackstageItem
  }
end



