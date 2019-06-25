RSpec.describe PhoneToWord do
  it 'has a version number' do
    expect(PhoneToWord::VERSION).not_to be nil
  end

  describe 'split_phone_string function' do
    before do
      @obj1= PhoneToWord::Transform.new('6686787825')
      @obj2= PhoneToWord::Transform.new(6686787825)
    end

    it 'returns the array of characters for phone' do
      arr = @obj1.send(:split_phone_string)
      expect(arr).to eq(['6','6','8','6','7','8','7','8','2','5'])
    end

    it 'accept integer phone value and returns the array of characters' do
      arr = @obj2.send(:split_phone_string)
      expect(arr).to eq(['6','6','8','6','7','8','7','8','2','5'])
    end
  end

  describe 'verify_from_store? method' do
    before do
      @obj= PhoneToWord::Transform.new('6686787825')
    end

    it 'return false if store is not assembled' do
      expect(@obj.send(:verify_from_store?, '224')).to eq false
    end

    it 'return true if combination exist in store' do
      @obj.send(:assemble_store)
      expect(@obj.send(:verify_from_store?, '224')).to eq true
    end

    it 'retrun false if combination does not exist in store' do
      @obj.send(:assemble_store)
      expect(@obj.send(:verify_from_store?, '001')).to eq false
    end
  end

  describe 'group_words_by_combination method' do
    before do
      @obj= PhoneToWord::Transform.new('6686787825')
    end

    it '' do
    end
  end

  describe 'assemble_store method' do
    before do
      @obj= PhoneToWord::Transform.new(phone = '6686787825', dictionary_path= 'a.txt' )
    end

    it 'raise exception if dictionary file does not exist' do
      expect { @obj.send(:assemble_store) }.to raise_error(RuntimeError)
    end
  end

  describe 'to_word method' do
    before do
      @obj1= PhoneToWord::Transform.new('6686787825')
      @obj2= PhoneToWord::Transform.new('1100101010')
    end

    it 'return the word combinations for phone' do
      @obj1.to_word.include? ['MOTORTRUCK']
      @obj1.to_word.include? ['MOTOR', 'TRUCK']
      @obj1.to_word.include? ['NOUN', 'STRUCK']
    end

    it 'raise exception if phone only consist 0s and 1s' do
      expect { @obj2.to_word }.to raise_error(RuntimeError)
    end
  end
end
