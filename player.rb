class Player
    attr_accessor :x,:y, :area
    def initialize(x,y,area)
       @x=x
       @y=y
       @area = area
    end

    def move(direction)
        case direction
            when direction[0]
                @x += 1
                
            when direction[1]
                @x -= 1
               
            when direction[2]
                @y -= 1
                
            when direction[3]
                @y += 1
                
            
        end
    end


end
