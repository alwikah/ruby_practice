wordlist = File.open("dictionary.txt","r") 

WORD_HASH = Hash.new()
wordarr= Array.new()

while !wordlist.eof?  
line = wordlist.gets.chomp 
wordarr<<line
end

#save all the words with the same length in a hash,with a key corresponding to that length
wordarr.each do |item|
	WORD_HASH[item.length] ||= []
	WORD_HASH[item.length] << item
end

#oder every array of equal-leghted words alphabetically
WORD_HASH.each do |key,value| 
	value.sort! 
end

wordlist.close 
   


class String

	#determine if 2 strings differ only by 1 letter
  def one_letter_diff?(s)
  	return false if self.length != s.length
 		a = s.chars.to_a
 		self.chars.each do |c|
   		if i = a.index(c)
      	a.delete_at(i)
    	end
  	end
  	a.length == 1
	end

end


class Word
    #diff_by1 - list of words that are different by 1 letter
    #f_path/b-path : the list of words used to determine the shortest paths from the start word forward 
     # or from the end word backwards
  attr_accessor:diff_by1, :f_path, :b_path

  def initialize(word)
  	@word= word
  	@diff_by1, @f_path, @b_path = [], [], []
  end

  def to_s
    @word
  end

  #True if current word differs from the provided word by a single character
  def one_letter_diff?(word)
    @word.one_letter_diff?(word.to_s)
  end

end


#A collection of words of the same lenght connected in the graph 
class Graph
  #lenght i.e. the correspondent key from the hash
	attr_accessor:len, :words


#Takes the lenght of words in this dictionary
  def initialize(len)
    @words = []
    @len = len
  end

	def Graph.make(len)
		graph= Graph.new(len)
		temp= WORD_HASH[len]

    temp.each do |w|
    	graph.add_word(Word.new(w))  
   	end
   	print @words
    return graph
  end 

   #Adds a word in the array @words and potentially connects it with other words that are 1 letter diff
  def add_word(new_word)
    @words.each do |word|
      if word.one_letter_diff?(new_word)
        word.diff_by1.push(new_word)
        new_word.diff_by1.push(word)
      end
    end
    @words.push(new_word)
  end

  #Searches in the dictionary the word corresponding to the string s
  def find_word(s)
    word = @words.find { |word| word.to_s == s }
    raise (" The word provided wasnt found") if (word == nil)
    return word
  end
  
  #Nice string repr
  def to_s
    "Dictionary of %d %d-letter words" % [@words.length, @word_length]
  end

  # Join forward and backwards paths of the joining word that fills the
  # shortest path
  def join_paths(word)
    word.f_path + (word.b_path.reverse)[1..-1]
  end

  # Find the shortest path from 'from' to 'to'. Unlike the calculate_all_paths
  # method, this doesn't leave the words in the dictionary in a useful enough
  # state to find any more information
  def find_path(from, to)
    #clean()
    from_words = [from]
    from.f_path = [from]
    
    to_words = [to]
    to.b_path = [to]
    
    until from_words.empty? or to_words.empty?
      next_words = []
      from_words.each do |word|
        word.diff_by1.each do |a|
          if a.f_path.length == 0
            a.f_path = word.f_path + [a]
            next_words.push(a)
          end
          return join_paths(a) if a.b_path.length != 0
        end      
      end
      from_words = next_words
      
      next_words = []
      to_words.each do |word|
        word.diff_by1.each do |a|
          if a.b_path.length == 0
            a.b_path = word.b_path + [a]
            next_words.push(a)
          end
          return join_paths(a) if a.f_path.length != 0
        end        
      end
      to_words = next_words
    end
    return []
  end

   # Reset all words in the dictionary so they're ready for a new search
  def clean
    @words.each do |word| 
      word.f_path = []
      word.b_path = []
    end
  end

end


graph = Graph.make(4)
from, to = graph.find_word("lead"), graph.find_word("gold")
print graph.find_path(from,to ).join(" -> ")
 	