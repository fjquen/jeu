require "gosu"
require './constant.rb'
require './area.rb'


class Main < Gosu::Window
	include Constant
	include Area

    def initialize
        super WIDTH, HEIGTH
        self.caption = "Game"
        @mazeCreate = Array.new(BLOCK_Y){Array.new(BLOCK_X,"#")}
        rand_position = rand(@mazeCreate.length-1)
        @x,@y=rand_position,rand_position
        @mazeCreate[@x][@y] = ' '
		area_game(LOOP, DIRECTION)
		position_player()
    end

    def update
        if Gosu.button_down? Gosu::KB_RIGHT
            @x_player += 1
            @mazeCreate[@y_player][@x_player]="$"
        end
    end
    

    
    def draw
        @mazeCreate.each_index do |row|
            @mazeCreate[row].each_index do |col|
                if @mazeCreate[row][col] == "#"
                    Gosu.draw_rect(col*BLOCK_Y, row*BLOCK_X, BLOCK_Y, BLOCK_X,Gosu::Color::BLUE)
                elsif @mazeCreate[row][col] == " "
                    Gosu.draw_rect(col*BLOCK_Y, row*BLOCK_X, BLOCK_Y, BLOCK_X,Gosu::Color::BLACK)
				elsif @mazeCreate[row][col] == "$"
                    Gosu.draw_rect(col*BLOCK_Y, row*BLOCK_X, BLOCK_Y, BLOCK_X,Gosu::Color::GREEN)
                end
            end
        end
    end
   
end

Main.new.show
