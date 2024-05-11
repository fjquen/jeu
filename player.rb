class Player
    attr_accessor :x,:y
    def initialize
        @x=@y=0
    end
    
    
    
    def draw
        Gosu.draw_rect(@x, @y, 15, 20,Gosu::Color::RED)
    end
end
