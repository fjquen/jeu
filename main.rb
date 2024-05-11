require "gosu"
require "./player.rb"

class Main < Gosu::Window
    def initialize
        super 660,495,false
        @world=[["#","#","#","#","#","#"],
                ["#"," "," "," "," ","#"],
                ["#"," "," ","#"," ","#"],
                ["#"," ","#","#"," ","#"],
                ["#"," "," "," "," ","#"],
                ["#"," "," "," "," ","#"],
                ["#"," "," "," "," ","#"],
                ["#","#","#","#","#","#"]]
        @player = Player.new
        @tabPositionPlayer = []
        @world.each_index do |row|
            @world[row].each_index do |col|
                if @world[row][col] == " "
                    @tabPositionPlayer<<{"x"=>row,"y"=>col}
                end
            end
        end
        rand = @tabPositionPlayer.sample
        @player.x, @player.y = rand["x"]*40,rand["y"]*40
    end

    def update
        
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
