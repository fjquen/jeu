class Player
    attr_accessor :area
    def initialize(area)
       @area = area
       @x_player=@y_player=0
    end

    def position_player()
		level = []
		@area.each_index {|y| 
		  @area[y].each_index {|x| 
			if @area[y][x] == " "
				level<<{"y"=>y,"x"=>x}
			end
		  }
		}
		rand_position = rand(level.length-1)
		x_player = level[rand_position]["x"]
		y_player = level[rand_position]["y"]
		@x_player = x_player
		@y_player = y_player
		area[y_player][x_player]="$"
    end

    def move(direction)
        
        case direction
            when "r"
              x = @x_player
              x+=1
              if area[@y_player][x] != "#"
                @x_player+=1
                area[@y_player][@x_player]= "$"                    
              end      
            when "l"
              x = @x_player
              x-=1
              if area[@y_player][x] != "#"
                @x_player-=1
                area[@y_player][@x_player]= "$"                    
              end      
            when "u"
              y = @y_player
              y-=1
              if area[y][@x_player] != "#"
                @y_player-=1
                area[@y_player][@x_player]= "$"                    
              end      
            when "d"
                y = @y_player
                y+=1
                if area[y][@x_player] != "#"
                  @y_player+=1
                  area[@y_player][@x_player]= "$"                    
                end
            
        end
    end


end
