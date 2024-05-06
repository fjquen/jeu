class Player
    def initialize
        @x=@y=0
    end

    def positionPlayer(x,y)
        @x = x
        @y = y
    end

    def draw
        Gosu.draw_rect(@x, @y, 15, 15,Gosu::Color::RED)
    end
end