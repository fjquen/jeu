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
        @player.x, @player.y = @tabPositionPlayer[4]["x"]*40,@tabPositionPlayer[4]["y"]*40
    end

    def update
        @player.y += 1
        if @world[@player.y/40][@player.x/40] == "#"
			@player.y -= 1 
        end
        
        new_x = @player.x - 1 if Gosu.button_down? Gosu::KB_LEFT or Gosu.button_down? Gosu::GP_LEFT
		new_x = @player.x + 1 if Gosu.button_down? Gosu::KB_RIGHT or Gosu.button_down? Gosu::GP_RIGHT
		
		if new_x && @world[@player.y/40][new_x/40] != "#"
		    @player.x = new_x
		elsif new_x && @world[@player.y/40][new_x/40] == "#"
		    if Gosu.button_down? Gosu::KB_RIGHT or Gosu.button_down? Gosu::GP_RIGHT
			   @player.x = new_x-20
			elsif Gosu.button_down? Gosu::KB_LEFT or Gosu.button_down? Gosu::GP_LEFT
			   @player.x = new_x+5
			end
		end
    end
    
    def button_down(id)
		case id
		when Gosu::KB_ESCAPE
		  close
		when Gosu::KB_UP
			if @world[(@player.y-30)/40][@player.x/40] < "#"
			  @player.y-=30
			else
			  @player.y+=30
			end
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
