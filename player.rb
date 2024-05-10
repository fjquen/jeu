class Player
    attr_accessor :x,:y
    def initialize
        @x=@y=0
    end

    def rigth
        @x+=1
    end
    
    def left
        @x-=1
    end
    
    def up
        @y-=15
    end
    
    def draw
        Gosu.draw_rect(@x, @y, 15, -20,Gosu::Color::RED)
    end
end
