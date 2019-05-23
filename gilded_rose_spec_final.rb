
require File.join(File.dirname(__FILE__), 'gilded_rose_final')

describe GildedRose do

  describe '#update_quality' do
    it 'decrease sell in value by 1 each day' do
      item = Item.new(name='Sample item', sell_in=4, quality=20)
      GildedRose.new([item]).update_quality
      expect(item.sell_in).to eq 3
    end

    it 'quality of an item is never negative' do
      item = Item.new(name='Sample item', sell_in=0, quality=0)
      GildedRose.new([item]).update_quality
      expect(item.quality).to eq 0
    end

    it 'quality of an item is never more than 50' do
      item = Item.new(name='Sample Item', sell_in=10, quality=50)
      GildedRose.new([item]).update_quality
      expect(item.quality).to be <= 50
    end

    context 'quality' do
      context 'sell in value is not over' do
        it 'decrease quality value by 1 each day' do
          item = Item.new(name='Sample item', sell_in=2, quality=5)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq 4
        end
      end

      context 'sell in value is over' do
        it 'decrease quality value by 2' do
          item = Item.new(name='Sample item', sell_in=0, quality=8)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq 6
        end
      end
    end

    context 'Conjured Mana Cake item' do
      context 'quality' do
        it 'decrease quality value by 2 each day' do
          item = Item.new('Conjured Mana Cake', sell_in=10, quality=10)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq 8
        end

        context 'sell in value is over' do
          it 'decrease quality value by 4' do
            item = Item.new('Conjured Mana Cake', sell_in=0, quality=10)
            GildedRose.new([item]).update_quality
            expect(item.quality).to eq 6
          end
        end
      end
    end

    context 'Backstage passes to a TAFKAL80ETC concert item' do
      context 'quality' do
        context 'sell in value is not over' do
          context 'sell in value > 10' do
            it 'increases by 1' do
              item = Item.new('Backstage passes to a TAFKAL80ETC concert', sell_in=15, quality=2)
              GildedRose.new([item]).update_quality
              expect(item.quality).to eq 3
            end
          end

          context 'sell in > 5 and  <= 10' do
            it 'increases by 2' do
              item = Item.new('Backstage passes to a TAFKAL80ETC concert', sell_in=9, quality=2)
              GildedRose.new([item]).update_quality
              expect(item.quality).to eq 4
            end

            it 'increases to 50, is never more than 50' do
              item = Item.new('Backstage passes to a TAFKAL80ETC concert', sell_in=1, quality=50)
              GildedRose.new([item]).update_quality
              expect(item.quality).to eq 50
            end
          end

          context 'sell in < 5' do
            it 'increases by 3' do
              item = Item.new('Backstage passes to a TAFKAL80ETC concert', sell_in=2, quality=10)
              GildedRose.new([item]).update_quality
              expect(item.quality).to eq 13
            end
          end
        end

        context 'sell in value is over' do
          it 'should be 0' do
            item = Item.new('Backstage passes to a TAFKAL80ETC concert', sell_in=0, quality=13)
            GildedRose.new([item]).update_quality
            expect(item.quality).to eq 0
          end
        end
      end
    end

    context 'Aged Brie Item' do
      context 'quality' do
        context 'sell in value is not over' do
          it 'quality increases by 1' do
            item = Item.new('Aged Brie', sell_in=7, quality=10)
            GildedRose.new([item]).update_quality
            expect(item.quality).to eq 11
          end
        end

        context 'sell in value is over' do
          it 'quality increases twice as fast' do
            item = Item.new('Aged Brie', sell_in=0, quality=20)
            GildedRose.new([item]).update_quality
            expect(item.quality).to eq 22
          end
        end
      end
    end

    context 'Sulfuras, Hand of Ragnaros Item' do
      context 'sell in' do
        it 'No change in sell in' do
          item = Item.new('Sulfuras, Hand of Ragnaros', sell_in=0, quality=0)
          GildedRose.new([item]).update_quality
          expect(item.sell_in).to eq 0
        end
      end

      context 'quality' do
        it 'no change in the quality' do
          item = Item.new('Sulfuras, Hand of Ragnaros', sell_in=0, quality=10)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq 10
        end
      end
    end
  end
end
