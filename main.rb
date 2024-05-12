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
        tabMap = @world.map { |row| row.each_index.select { |i| row[i] != "#" } }
        x_position = tabMap[rand(tabMap.size)].size*40 
        y_position = rand(0..tabMap[rand(tabMap.size)].size)*40
        @player.x, @player.y = x_position == 0 ? 40 : x_position,y_position == 0 ? 40 : y_position
    end

    def update
        if Gosu.button_down? Gosu::KB_RIGHT
			puts "d"
        end
        if Gosu.button_down? Gosu::KB_LEFT
			puts "g"
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
