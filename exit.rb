class Exit
    attr_accessor :area
    def initialize(area)
       @area = area
       @x_exit=@y_exit=0
    end


    def position_exit(void,goal)
		level = []
		@area.each_index {|y| 
		  @area[y].each_index {|x| 
			if @area[y][x]["o"] == void
				level<<{"y"=>y,"x"=>x}
			end
		  }
		}
    
		rand_position = rand(level.length-1) 
		@x_exit = level[rand_position]["x"]
		@y_exit = level[rand_position]["y"]
        @area[@y_exit][@x_exit]["o"]= goal
    end


	def x_exit
		return @x_exit
	end
  
	def y_exit
		return @y_exit
	end
end