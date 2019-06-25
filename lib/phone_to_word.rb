require './lib/phone_to_word/version.rb'

module PhoneToWord
  class Error < RuntimeError; end

  class Transform
    MIN_LENGTH = 3
    def initialize(phone, dictionary_path = 'dictionary.txt')
      @phone = phone.to_s
      @store = Hash.new { |number, wrds| number[wrds] = [] }
      @dictionary_path = dictionary_path
      @result = []
    end

    # Converts the phone number to possible words
    def to_word
      raise RuntimeError, 'Phone with only 0 and 1 can not be transformed!' if @phone.split('').reject { |i| %w[0 1].include? i }.empty?

      assemble_store
      grouped_wrds = group_words_by_combination.flatten.group_by(&:size)
      MIN_LENGTH.upto(@phone.length) do |i|
        @result << grouped_wrds[i] if i.eql? @phone.length
        next if @phone.length - i < MIN_LENGTH

        @result << grouped_wrds[i].product(grouped_wrds[(@phone.length - i)])
      end
      @result
    end

    private

    # Read the dictionary file and generate the store data set
    def assemble_store
      raise RuntimeError, 'Could not Find the Directory, Please make sure dictionary file path is correct!' unless File.exist? @dictionary_path

      File.open(@dictionary_path) do |file|
        file.each_line do |line|
          @store[(n = line.chomp).gsub(/A|B|C/i, '2')
                                 .gsub(/D|E|F/i, '3')
                                 .gsub(/G|H|I/i, '4')
                                 .gsub(/J|K|L/i, '5')
                                 .gsub(/M|N|O/i, '6')
                                 .gsub(/P|Q|R|S/i, '7')
                                 .gsub(/T|U|V/i, '8')
                                 .gsub(/W|X|Y|Z/i, '9')] += [n]
        end
      end
    end

    # Generate the possible combinations for phone number and convert to words
    def group_words_by_combination
      corsponding_words = []
      MIN_LENGTH.upto(@phone.length).each do |combination_size|
        split_phone_string.combination(combination_size).to_a.uniq.each do |comb|
          corsponding_words << @store[comb.join] if verify_from_store? comb.join
        end
      end
      corsponding_words
    end

    def verify_from_store?(comb)
      @store[comb].empty? ? false : true
    end

    def split_phone_string
      @phone.split('')
    end
  end
end

# uncomment following line to check the result
# p PhoneToWord::Transform.new('6686787825').to_word