module Area
    def area_game(cycle,direction)
        cycle.times { |i| 
		case direction.sample
			when "r"
			 x=@x+1
			 if @mazeCreate[@y][x] == '#' and x<@mazeCreate.length-1 and !@mazeCreate[@y][x].nil?
				@x=x
				@mazeCreate[@y][@x] = ' '
			 end
			 
			when "l"
			 x=@x-1
			 if @mazeCreate[@y][x] == '#' and x>0 and !@mazeCreate[@y][x].nil?
				@x=x
				@mazeCreate[@y][@x] = ' '
			 end
			 
			when "d"
			y=@y+1
			if @mazeCreate[y][@x] == '#' and y<@mazeCreate.length-1 and !@mazeCreate[y][@x].nil?
				@y=y
				@mazeCreate[@y][@x] = ' '
			end
			
			when "u"
			 y=@y-1
			 if @mazeCreate[y][@x] == '#' and y>0 and !@mazeCreate[y][@x].nil?
				@y=y
				@mazeCreate[@y][@x] = ' '
			 end
			 
		   end 
	   }
    end

    def player()
        puts @mazeCreate.map.with_index { |x, i| x * i }
    end
end