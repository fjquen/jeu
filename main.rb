require "gosu"
require "./player.rb"

class Main < Gosu::Window
    def initialize
        super 660,495,false
        @world=[["#","#","#","#","#","#","#","#","#","#","#","#"],
                ["#"," "," "," "," "," "," "," "," "," "," ","#"],
                ["#"," "," ","#"," "," "," "," "," "," "," ","#"],
                ["#"," ","#","#"," "," "," "," "," "," "," ","#"],
                ["#"," "," "," "," "," "," "," "," "," "," ","#"],
                ["#"," "," "," "," "," "," "," "," "," "," ","#"],
                ["#"," "," "," "," "," "," "," "," "," "," ","#"],
                ["#"," "," "," "," "," "," "," "," "," "," ","#"],
                ["#"," "," "," "," "," "," "," "," "," "," ","#"],
                ["#"," "," "," "," "," "," "," "," "," "," ","#"],
                ["#"," "," "," "," "," "," "," "," "," "," ","#"],
                ["#","#","#","#","#","#","#","#","#","#","#","#"]]
        @player = Player.new
        @tabMap = @world.map { |row| row.each_index.select { |i| row[i] != "#" } }
        x_position = @tabMap[rand(@tabMap.size)].size*42 
        y_position = rand(0..@tabMap[rand(@tabMap.size)].size)*42
        @player.x, @player.y = x_position == 0 ? 42 : x_position,y_position == 0 ? 42 : y_position
        @width=@higth = 40
    end

    def update
        if @world[@player.y/40][@player.x/40]!="#"
		    @player.y+=1
	    end
		
		if Gosu.button_down? Gosu::KB_RIGHT
			if @world[@player.y/40][@player.x/40]!="#"
				@player.x+=1
			end
		end
		
		if Gosu.button_down? Gosu::KB_LEFT
		  if @world[@player.y/40][@player.x/40]!="#"
			@player.x-=1
		  end
		end	
    end
    


	def button_down(id)
		case id
			when Gosu::KB_UP
			  @player.y-=18
			when Gosu::KB_ESCAPE
			  close
		end
    end
    
    def draw
        @player.draw
        @world.each_index do |row|
            @world[row].each_index do |col|
                if @world[row][col] == "#"
                    Gosu.draw_rect(col*40, row*40, @width, @higth,Gosu::Color::BLUE)
                end
            end
        end
    end
   
end

Main.new.show
