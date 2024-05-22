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

    def position_player()
		level = []
		@mazeCreate.each_index {|y| 
		  @mazeCreate[y].each_index {|x| 
			if @mazeCreate[y][x] == " "
				level<<{"y"=>y,"x"=>x}
			end
		  }
		}
		rand_position = rand(level.length-1)
		x_player = level[rand_position]["x"]
		y_player = level[rand_position]["y"]
		@x_player = x_player
		@y_player = y_player
		@mazeCreate[y_player][x_player]="$"
    end
end