class Player
    attr_accessor :x,:y,:l,:h
    def initialize
        @x=@y=0
        @l=@h=20
    end
    
    
    def draw
        Gosu.draw_rect(@x, @y, @l, @h,Gosu::Color::RED)
    end
end
