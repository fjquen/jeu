class Ennemy
    attr_accessor :area
    def initialize(area)
       @area = area
       @x_ennemy=@y_ennemy=0
    end


	def move(x_player,y_player,wall,ennemy,void,goal)
		if @x_ennemy < x_player 
				x = @x_ennemy
				x+=1
				if area[@y_ennemy][x]["o"] == void
				  @x_ennemy+=1
				  @area[@y_ennemy][@x_ennemy]["o"]= ennemy
				  x-=1
				  @area[@y_ennemy][x]["o"]= void         
				end 
		elsif @x_ennemy > x_player 
			x = @x_ennemy
			x-=1
			if area[@y_ennemy][x]["o"] == void
				@x_ennemy-=1
				@area[@y_ennemy][@x_ennemy]["o"]= ennemy
				x+=1
				@area[@y_ennemy][x]["o"]= void
			end
		elsif @y_ennemy < y_player 
			y = @y_ennemy
			y+=1
			if area[y][@x_ennemy]["o"] == void
				@y_ennemy+=1
				area[@y_ennemy][@x_ennemy]["o"]= ennemy
				y-=1
				@area[y][@x_ennemy]["o"]= void                    
			end
		elsif @y_ennemy > y_player 
			y = @y_ennemy
			y-=1
			if area[y][@x_ennemy]["o"] == void
				@y_ennemy-=1
				area[@y_ennemy][@x_ennemy]["o"]= ennemy
				y+=1
				@area[y][@x_ennemy]["o"]= void                    
			end
		end
	end

    def position_ennemy(void,ennemy)
		level = []
		@area.each_index {|y| 
		  @area[y].each_index {|x| 
			if @area[y][x]["o"] == void
				level<<{"y"=>y,"x"=>x}
			end
		  }
		}
    
		rand_position = rand(level.length-1) 
		@x_ennemy= level[rand_position]["x"]
		@y_ennemy = level[rand_position]["y"]
        @area[@y_ennemy][@x_ennemy]["o"]= ennemy
    end


	def x_ennemy
		return @x_ennemy
	end

	def y_ennemy
		return @y_ennemy
	end
end