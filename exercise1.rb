


wordlist = File.open("dictionary.txt","r") 

#def Dictionary.load(word_length)
 #   dict = Dictionary.new(word_length)
    
  #  IO.foreach("wordlist.txt") do |line|
   #   line.strip!
    #  dict.add_word(Word.new(line)) if line.length == word_length
    #end
    
    #return dict
  #end
words_hash = Hash.new()
wordarr= Array.new()

while !wordlist.eof?  
line = wordlist.gets.chomp 
wordarr<<line
end

#save all the words with the same length in a hash,with a key corresponding to that length
wordarr.each do |item|
	words_hash[item.length] ||= []
	words_hash[item.length] << item
end

#oder every array of equal-leghted words alphabetically
words_hash.each do |key,value| 
	value.sort! 
end

#make an array of all the keys in the hash and order it
key_arr= words_hash.keys.sort!
l = 5
arr5= words_hash[l]

wordlist.close 

sorted= Array.new()
#in the resulting array, collect from the hash all the arrays corresponding to the keys, in order
sorted= key_arr.collect{|key| words_hash[key] }

#myfile = File.open("result.txt",'w') #open another one/

#sorted.each do |item| 
#	item.each do |el|
 #	myfile.write("#{el}\n")
 #end
#end

 #myfile.close 
 puts arr5
    

  #def search(w1)
  #	warr= words_hash.fetch(w1.length)
  #	return false if !(arr.include?(w1))
   # return true
  #end


 











