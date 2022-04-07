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
  end

end
