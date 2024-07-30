class Player
    attr_accessor :area
    def initialize(area)
       @area = area
       @x_player=@y_player=0
    end

    def position_player(void,player)
		level = []
		@area.each_index {|y| 
		  @area[y].each_index {|x| 
			if @area[y][x]["o"] == void
				level<<{"y"=>y,"x"=>x}
			end
		  }
		}
    
		rand_position = rand(level.length-1) 
		@x_player = level[rand_position]["x"]
		@y_player = level[rand_position]["y"]
    @area[@y_player][@x_player]["o"]= player
    end

    def move(direction,wall,void,player)
        case direction
            when "r"
              x = @x_player
              x+=1
              if area[@y_player][x]["o"] == void
                @x_player+=1
                @area[@y_player][@x_player]["o"]= player
                x-=1
                @area[@y_player][x]["o"]= void         
              end      
            when "l"
              x = @x_player
              x-=1
              if area[@y_player][x]["o"] == void
                @x_player-=1
                area[@y_player][@x_player]["o"]= player
                x+=1
                @area[@y_player][x]["o"]= void                    
              end      
            when "u"
              y = @y_player
              y-=1
              if area[y][@x_player]["o"] == void
                @y_player-=1
                area[@y_player][@x_player]["o"]= player
                y+=1
                @area[y][@x_player]["o"]= void                    
              end      
            when "d"
                y = @y_player
                y+=1
                if area[y][@x_player]["o"] == void
                  @y_player+=1
                  area[@y_player][@x_player]["o"]= player
                  y-=1
                  @area[y][@x_player]["o"]= void                    
                end
            
        end
    end

    def x_player
      return @x_player
    end

    def y_player
      return @y_player
    end

end
