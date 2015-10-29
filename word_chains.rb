class WordChainer
  def initialize(dictionary = nil)

    @dictionary ||= File.readlines("dictionary.txt").map(&:chomp)
  end

  def adjacent_words(word)
    @dictionary.select do |dict_word|
      (dict_word.size == word.size) && off_by_one?(word, dict_word)
    end
  end

  def off_by_one?(word1, word2)
    index = 0
    counter = 0
      while index < word1.length
        if word1[index] == word2[index]
          counter += 1
          index +=1
        else
          index +=1
        end
      end
    return true if counter == word1.length-1
    false
  end
end

a = WordChainer.new
p a.adjacent_words("hello")
