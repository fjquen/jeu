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
        @world.each_index do |row|
            @world[row].each_index do |col|
                if @world[row][col] == " "
                    @tabPositionPlayer<<{"x"=>row,"y"=>col}
                end
            end
        end
        @player.x, @player.y = @tabPositionPlayer[4]["x"]*40,@tabPositionPlayer[4]["y"]*40
    end

    def update
        @world.each_index do |row|
            @world[row].each_index do |col|
                if @world[@player.y/40][@player.x/40] == "#"
                    @bool = false
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
        
        if Gosu.button_down? Gosu::KB_LEFT or Gosu.button_down? Gosu::GP_LEFT
            @player.left
        end
    end
    
    def button_down(id)
		case id
		when Gosu::KB_ESCAPE
		  close
		when Gosu::KB_UP
		  @player.up
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
