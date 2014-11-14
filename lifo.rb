class List
    def initialize()
    	@array = Array.new()
    	@l = 0
     end

        def add(item)
           @array[@l] = item
           @l= @l+1
        end

        def remove ()  
        	if(@l == 0)
             puts "The list is empty."
            else  
             array1= @array[0..@l-2]
             @array= array1 
        	end 
        end

        def print()
     	   puts @array
        end


     def exit 
        puts "Continue? ( y/n )"
        if( gets.chomp == "y")
        	self.menu()
        else
        	abort 
        end
    end


     def menu
     	puts "Choose between: add,remove,print"
        case gets.strip
        when "add"
        	self.add(gets.chomp)
             self.exit()
        when "remove"
        	self.remove()
        	self.exit()
        when "print"
        	self.print()
        	self.exit()
        end
     end
 
end

list = List.new()

list.menu()


 
