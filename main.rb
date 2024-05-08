require "gosu"
require "./player.rb"

class Main < Gosu::Window
    def initialize
        super 660,495,false
        @world=[["#","#","#","#","#","#"],
                ["#"," "," "," "," ","#"],
                ["#"," "," "," "," ","#"],
                ["#"," "," ","#"," ","#"],
                ["#"," ","#","#"," ","#"],
                ["#"," "," "," "," ","#"],
                ["#"," "," "," "," ","#"],
                ["#","#","#","#","#","#"]]
        @player = Player.new
        @bool = true
        @tabPositionPlayer = []
        @tabPositionWall = []
        @world.each_index do |row|
            @world[row].each_index do |col|
                if @world[row][col] == " "
                    @tabPositionPlayer<<{"x"=>row,"y"=>col}
                end

                if @world[row][col] == "#"
                    @tabPositionWall<<{"x"=>row,"y"=>col}
                end
            end
        end
        @player.positionPlayer(@tabPositionPlayer[4]["x"]*40,@tabPositionPlayer[4]["y"]*40)
    end

    def update
        @world.each_index do |row|
            @world[row].each_index do |col|
                if @world[@player.y/40][@player.x/40] == "#"
                    @bool = false
                    puts @world[@player.x/40][@player.y/40]
                elsif @world[@player.y/40][@player.x/40] == " "
                    @bool = true
                end
            end
        end

        if @bool
            @player.y += 1
        end
       
        if Gosu.button_down? Gosu::KB_RIGHT or Gosu.button_down? Gosu::GP_RIGHT
            @player.rigth
        end
    end

    def draw
        @player.draw
        @world.each_index do |row|
            @world[row].each_index do |col|
                if @world[row][col] == "#"
                    Gosu.draw_rect(col*40, row*40, 40, 40,Gosu::Color::BLUE)
                end
            end
        end
    end
   
end

Main.new.show