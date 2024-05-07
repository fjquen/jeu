class Player
    attr_accessor :x,:y, :bool
    def initialize
        @x=@y=0
        @bool = true
    end

    def positionPlayer(x,y)
        @x = x
        @y = y
    end
    
    def tabPosition(tab)
       tab.each do |i|
          puts @x
          puts @y
          puts "- nombre = #{i["x"]*40}"
          puts "- nombre = #{i["y"]*40}"
          if i["y"]*40==@y
              @bool = false
          end
          
       end
    end

    def rigth
        @x+=1
    end
    def draw
        Gosu.draw_rect(@x, @y, 15, 15,Gosu::Color::RED)
    end
end