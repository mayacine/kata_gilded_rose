require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    context 'Une fois que la date de péremption est passée' do
      it 'la qualité se dégrade deux fois plus rapidement.' do
      #given
       items = [Item.new("foo", 0, 8)]
      #when
        GildedRose.new(items).update_quality()
        GildedRose.new(items).update_quality()
      #then
        expect(items[0].quality).to eq 4
      end
    end 

    context "Quand la date de péremption n'est pas passée" do
      it "la qualite se degrade" do
      #given
       items = [Item.new("foo", 4, 8)]
      #when
        GildedRose.new(items).update_quality()
        GildedRose.new(items).update_quality()
        GildedRose.new(items).update_quality()
      #then
        expect(items[0].quality).to eq 5
      end
    end

    it "La qualité (quality) d'un produit ne peut jamais être négative" do
      items = [Item.new("foo", 14, 2)]

      GildedRose.new(items).update_quality()
      GildedRose.new(items).update_quality()
      GildedRose.new(items).update_quality()
      GildedRose.new(items).update_quality()
      
      expect(items[0].quality).not_to  be < 0
    end

    it '"Aged Brie" augmente sa qualité (quality) plus le temps passe.' do
      items = [Item.new(name="Aged Brie", sell_in=6, quality=0)]

      GildedRose.new(items).update_quality()
      GildedRose.new(items).update_quality()

      expect(items[0].quality).to eq 2
    end

    context "La qualité d'un produit n'est jamais de plus de 50." do

      it 'la qualite de Aged Brie ne depasse pas 50' do
        items = [Item.new(name="Aged Brie", sell_in=6, quality=49)]

        GildedRose.new(items).update_quality()
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 50
      end
    end

    it 'raise une error si quality > 50' do
      expect { DefaultItem.new('default item', 5, 60) }.to raise_error StandardError
      expect { AgedBrie.new('default item', 5, 60) }.to raise_error StandardError
    end

    it 'build aged Brie object' do
      ab = Item.new(name="Aged Brie", sell_in=6, quality=49)
      expect(ItemBuilder.new(item: ab).build).to be_a_kind_of(AgedBrie) 
    end
  end
end
