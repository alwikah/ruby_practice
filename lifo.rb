class List
    def initialize(size=0)
    	@array= Array.new(size)
    	@size=size
     end
        attr_reader:array 
        attr_accessor:size 

        def add(item)
           @size=@size+1
           @array[size]= item
        end

        def remove ()  
        	@array[size]= nil
            if (size != 0)
            	@size=@size-1
            else 
            	puts " The array is already empty"
            end
        end


     def print()
     	puts @array
     end

end

list= List.new()
list.add("first")
list.add(1)
list.add([3,4,6])
list.print()
list.remove()
list.print()


